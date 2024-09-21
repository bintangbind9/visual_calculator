part of 'calculation_history_bloc.dart';

@immutable
sealed class CalculationHistoryEvent {}

class AddCalculationHistory extends CalculationHistoryEvent {
  final CalculationHistory calculationHistory;
  AddCalculationHistory({required this.calculationHistory});
}

class RemoveCalculationHistory extends CalculationHistoryEvent {
  final CalculationHistory calculationHistory;
  RemoveCalculationHistory({required this.calculationHistory});
}

class SetCalculationHistory extends CalculationHistoryEvent {
  final List<CalculationHistory> calculationHistories;
  SetCalculationHistory({required this.calculationHistories});
}
