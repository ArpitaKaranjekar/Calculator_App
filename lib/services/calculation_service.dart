import 'package:calculator_app/services/firebase_service.dart';
import 'package:math_expressions/math_expressions.dart';

class CalculationService {
  final FirebaseService _firebaseService = FirebaseService();

  String calculate(String expression) {
    try {
      Parser parser = Parser();
      Expression exp = parser.parse(expression.replaceAll('x', '*'));
      ContextModel contextModel = ContextModel();
      double eval = exp.evaluate(EvaluationType.REAL, contextModel);
      return eval % 1 == 0 ? eval.toInt().toString() : eval.toString();
    } catch (e) {
      throw Exception('Calculation error');
    }
  }

  Future<void> saveCalculation(String calculation, String result) async {
    await _firebaseService.saveCalculation(calculation, result);
  }
}
