import 'package:math_expressions/math_expressions.dart';

class Calculator {
  late Parser _parser;
  late ContextModel _contextModel;

  Calculator() {
    _parser = Parser();
    _contextModel = ContextModel();
  }

  double evaluate(String expression) {
    final exp = _parser.parse(expression);
    return exp.evaluate(EvaluationType.REAL, _contextModel);
  }
}
