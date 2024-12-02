import 'package:calculator_app/widgets/calculator_button.dart';
import 'package:flutter/material.dart';

class CalculatorKeypad extends StatelessWidget {
  final bool darkMode;
  final Function(String) onButtonPressed;

  const CalculatorKeypad({
    super.key,
    required this.darkMode,
    required this.onButtonPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildButtonRow(['sin', 'cos', 'tan', '%']),
        _buildButtonRow(['AC', '(', ')', '/']),
        _buildButtonRow(['7', '8', '9', 'x']),
        _buildButtonRow(['4', '5', '6', '-']),
        _buildButtonRow(['1', '2', '3', '+']),
        _buildButtonRow(['0', '.', 'DEL', '=']),
      ],
    );
  }

  Widget _buildButtonRow(List<String> buttons) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: buttons.map((button) {
        return CalculatorButton(
          value: button,
          darkMode: darkMode,
          onPressed: () => onButtonPressed(button),
        );
      }).toList(),
    );
  }
}
