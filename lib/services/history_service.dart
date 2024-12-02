import 'package:calculator_app/services/firebase_service.dart';
import 'package:flutter/material.dart';

class HistoryService {
  final FirebaseService _firebaseService = FirebaseService();

  Future<void> showClearHistoryDialog(BuildContext context) async {
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
                _firebaseService.clearHistory();
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
