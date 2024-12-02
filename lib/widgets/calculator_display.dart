import 'package:flutter/material.dart';

class CalculatorDisplay extends StatelessWidget {
  final String question;
  final String answer;
  final bool darkMode;

  const CalculatorDisplay({
    super.key,
    required this.question,
    required this.answer,
    required this.darkMode,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Align(
          alignment: Alignment.bottomRight,
          child: LayoutBuilder(
            builder: (context, constraints) {
              double fontSize = 55.0;
              if (question.length > 15) fontSize = 45.0;
              if (question.length > 20) fontSize = 35.0;
              if (question.length > 30) fontSize = 30.0;

              return Text(
                question,
                style: TextStyle(
                  fontSize: fontSize,
                  fontWeight: FontWeight.bold,
                  color: darkMode ? Colors.white : Colors.black,
                ),
              );
            },
          ),
        ),
        Align(
          alignment: Alignment.bottomRight,
          child: Text(
            answer,
            style: TextStyle(
              fontSize: 30,
              color: darkMode ? Colors.white : Colors.grey,
            ),
          ),
        ),
      ],
    );
  }
}
