const String calculationHistoryTable = 'calculation_history';
const String idColumn = 'id';
const String expressionColumn = 'expression';
const String resultColumn = 'result';

const String createCalculationHistoryTable =
    '''CREATE TABLE IF NOT EXISTS "$calculationHistoryTable" (
        "$idColumn"	INTEGER NOT NULL,
        "$expressionColumn"	TEXT NOT NULL,
        "$resultColumn"	REAL NOT NULL,
        PRIMARY KEY("$idColumn" AUTOINCREMENT)
      );''';

class CalculationHistory {
  final int id;
  final String expression;
  final num result;

  CalculationHistory({
    this.id = 0,
    required this.expression,
    required this.result,
  });

  factory CalculationHistory.fromJson(Map<String, dynamic> json) =>
      CalculationHistory(
        id: json[idColumn],
        expression: json[expressionColumn],
        result: json[resultColumn],
      );

  Map<String, dynamic> toJson() => {
        expressionColumn: expression,
        resultColumn: result,
      };
}
