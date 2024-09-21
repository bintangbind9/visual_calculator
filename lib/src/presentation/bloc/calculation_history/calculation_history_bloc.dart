import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

import '../../../domain/entity/calculation_history.dart';

part 'calculation_history_event.dart';
part 'calculation_history_state.dart';

class CalculationHistoryBloc
    extends Bloc<CalculationHistoryEvent, CalculationHistoryState> {
  CalculationHistoryBloc()
      : super(const CalculationHistoryInitial(calculationHistories: [])) {
    on<AddCalculationHistory>((event, emit) {
      emit(CalculationHistoryUpdating(
        calculationHistories: state.calculationHistories,
      ));

      emit(CalculationHistoryUpdated(
          calculationHistories:
              List<CalculationHistory>.from(state.calculationHistories)
                ..add(event.calculationHistory)));
    });

    on<RemoveCalculationHistory>((event, emit) {
      emit(CalculationHistoryUpdating(
        calculationHistories: state.calculationHistories,
      ));

      emit(CalculationHistoryUpdated(
          calculationHistories:
              List<CalculationHistory>.from(state.calculationHistories)
                ..removeWhere((e) => e.id == event.calculationHistory.id)));
    });

    on<SetCalculationHistory>((event, emit) {
      emit(CalculationHistoryUpdating(
        calculationHistories: state.calculationHistories,
      ));

      emit(CalculationHistoryUpdated(
        calculationHistories: event.calculationHistories,
      ));
    });
  }
}
