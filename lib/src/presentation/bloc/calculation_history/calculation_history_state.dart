part of 'calculation_history_bloc.dart';

@immutable
sealed class CalculationHistoryState {
  final List<CalculationHistory> calculationHistories;

  const CalculationHistoryState({
    required this.calculationHistories,
  });
}

final class CalculationHistoryInitial extends CalculationHistoryState {
  const CalculationHistoryInitial({required super.calculationHistories});
}

final class CalculationHistoryUpdating extends CalculationHistoryState {
  const CalculationHistoryUpdating({required super.calculationHistories});
}

final class CalculationHistoryUpdated extends CalculationHistoryState {
  const CalculationHistoryUpdated({required super.calculationHistories});
}
