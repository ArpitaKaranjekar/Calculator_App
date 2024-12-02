import 'package:calculator_app/widgets/button_container.dart';
import 'package:flutter/material.dart';

class CalculatorButton extends StatelessWidget {
  final String value;
  final bool darkMode;
  final VoidCallback onPressed;

  const CalculatorButton({
    super.key,
    required this.value,
    required this.darkMode,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    if (['sin', 'cos', 'tan', '%'].contains(value)) {
      return _buildOvalButton();
    } else if (value == 'DEL') {
      return _buildIconButton();
    } else {
      return _buildRoundedButton();
    }
  }

  Widget _buildOvalButton() {
    return GestureDetector(
      onTap: onPressed,
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: ButtonContainer(
          darkMode: darkMode,
          borderRadius: BorderRadius.circular(50),
          padding: const EdgeInsets.symmetric(horizontal: 19, vertical: 9.5),
          child: Text(
            value,
            style: TextStyle(
              color: darkMode ? Colors.white : Colors.black,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildIconButton() {
    return _buildBaseButton(
      child: Icon(
        Icons.backspace_outlined,
        color: darkMode ? Colors.white : Colors.black,
        size: 30,
      ),
    );
  }

  Widget _buildRoundedButton() {
    return _buildBaseButton(
      child: Text(
        value,
        style: TextStyle(
          color: darkMode ? Colors.white : Colors.black,
          fontSize: 25,
        ),
      ),
    );
  }

  Widget _buildBaseButton({required Widget child}) {
    return GestureDetector(
      onTap: onPressed,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ButtonContainer(
          darkMode: darkMode,
          borderRadius: BorderRadius.circular(40),
          padding: const EdgeInsets.all(17),
          child: SizedBox(
            width: 34,
            height: 34,
            child: Center(child: child),
          ),
        ),
      ),
    );
  }
}
