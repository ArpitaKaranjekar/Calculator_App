import 'package:calculator_app/widgets/button_container.dart';
import 'package:flutter/material.dart';

class ThemeSwitch extends StatelessWidget {
  final bool darkMode;
  final VoidCallback onToggle;

  const ThemeSwitch({
    super.key,
    required this.darkMode,
    required this.onToggle,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onToggle,
      child: ButtonContainer(
        darkMode: darkMode,
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
        borderRadius: BorderRadius.circular(40),
        child: SizedBox(
          width: 70,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Icon(
                Icons.wb_sunny,
                color: darkMode ? Colors.grey : Colors.black,
              ),
              Icon(
                Icons.nightlight_round,
                color: darkMode ? Colors.white : Colors.grey,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
