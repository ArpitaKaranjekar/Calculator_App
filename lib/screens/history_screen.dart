import 'package:calculator_app/services/history_service.dart';
import 'package:calculator_app/widgets/history_list.dart';
import 'package:flutter/material.dart';

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Calculation History',
          style: TextStyle(color: Colors.black87),
        ),
        backgroundColor: Colors.white,
        elevation: 1,
        iconTheme: const IconThemeData(color: Colors.black87),
        actions: [
          IconButton(
            icon: const Icon(Icons.delete_outline),
            onPressed: () => HistoryService().showClearHistoryDialog(context),
          ),
        ],
      ),
      body: const HistoryList(),
    );
  }
}
