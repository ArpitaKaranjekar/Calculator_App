import 'package:calculator_app/constants/colors.dart';
import 'package:calculator_app/screens/history_screen.dart';
import 'package:calculator_app/services/calculation_service.dart';
import 'package:calculator_app/widgets/calculator_display.dart';
import 'package:calculator_app/widgets/calculator_keypad.dart';
import 'package:calculator_app/widgets/theme_switch.dart';
import 'package:flutter/material.dart';

class CalculatorScreen extends StatefulWidget {
  const CalculatorScreen({super.key});

  @override
  State<CalculatorScreen> createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  final CalculationService _calculationService = CalculationService();
  bool darkMode = false;
  String question = '';
  String answer = '';

  void _handleButtonPress(String value) async {
    setState(() {
      if (value == 'AC') {
        question = '';
        answer = '';
      } else if (value == 'DEL') {
        if (question.isNotEmpty) {
          question = question.substring(0, question.length - 1);
        }
      } else if (value == '=') {
        _calculateResult();
      } else {
        question += value;
      }
    });
  }

  void _calculateResult() async {
    try {
      final result = _calculationService.calculate(question);
      setState(() => answer = result);
      await _calculationService.saveCalculation(question, result);
    } catch (e) {
      setState(() => answer = 'Error');
      _showErrorSnackBar();
    }
  }

  void _showErrorSnackBar() {
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Failed to save calculation'),
        backgroundColor: Colors.red,
      ),
    );
  }

  void _toggleTheme() {
    setState(() => darkMode = !darkMode);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
          darkMode ? AppColors.darkBackground : AppColors.lightBackground,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(18),
          child: Stack(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ThemeSwitch(
                    darkMode: darkMode,
                    onToggle: _toggleTheme,
                  ),
                  const SizedBox(height: 80),
                  CalculatorDisplay(
                    question: question,
                    answer: answer,
                    darkMode: darkMode,
                  ),
                  const SizedBox(height: 30),
                  CalculatorKeypad(
                    darkMode: darkMode,
                    onButtonPressed: _handleButtonPress,
                  ),
                ],
              ),
              Positioned(
                right: 0,
                top: 0,
                child: IconButton(
                  icon: Icon(
                    Icons.history,
                    color: darkMode ? Colors.white : Colors.black,
                  ),
                  onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const HistoryScreen(),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
