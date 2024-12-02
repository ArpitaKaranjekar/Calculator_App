import 'package:calculator_app/history_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class HistoryList extends StatelessWidget {
  const HistoryList({Key? key}) : super(key: key);

  String _formatTimestamp(dynamic timestamp) {
    if (timestamp == null) {
      return 'No date';
    }

    if (timestamp is Timestamp) {
      final dateTime = timestamp.toDate();
      return DateFormat('MMM d, y HH:mm').format(dateTime);
    }

    return 'Invalid date';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('calculation_history')
            .orderBy('timestamp', descending: true)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(
              child: Text(
                'Error: ${snapshot.error}',
                style: const TextStyle(color: Colors.red),
              ),
            );
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.history,
                    size: 64,
                    color: Colors.grey,
                  ),
                  SizedBox(height: 16),
                  Text(
                    'No calculations yet!',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            );
          }

          return ListView.separated(
            padding: const EdgeInsets.all(16),
            itemCount: snapshot.data!.docs.length,
            separatorBuilder: (context, index) => const Divider(height: 1),
            itemBuilder: (context, index) {
              final doc = snapshot.data!.docs[index];
              final data = doc.data() as Map<String, dynamic>;

              return HistoryTile(
                calculation:
                    data['calculation']?.toString() ?? 'Unknown calculation',
                result: data['result']?.toString() ?? 'Unknown result',
                timestamp: _formatTimestamp(data['timestamp']),
                onDelete: () => _deleteHistoryItem(doc.id),
              );
            },
          );
        },
      ),
    );
  }
}

Future<void> _showClearHistoryDialog(BuildContext context) async {
  return showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Clear History'),
        content: const Text(
            'Are you sure you want to clear all calculation history?'),
        actions: [
          TextButton(
            child: const Text('Cancel'),
            onPressed: () => Navigator.of(context).pop(),
          ),
          TextButton(
            child: const Text('Clear'),
            onPressed: () {
              _clearHistory();
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}

Future<void> _clearHistory() async {
  try {
    final collection =
        FirebaseFirestore.instance.collection('calculation_history');
    final snapshots = await collection.get();
    for (var doc in snapshots.docs) {
      await doc.reference.delete();
    }
  } catch (e) {
    print('Error clearing history: $e');
  }
}

Future<void> _deleteHistoryItem(String docId) async {
  try {
    await FirebaseFirestore.instance
        .collection('calculation_history')
        .doc(docId)
        .delete();
  } catch (e) {
    print('Error deleting history item: $e');
  }
}
