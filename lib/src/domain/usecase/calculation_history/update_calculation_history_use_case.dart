import 'package:get_it/get_it.dart';

import '../../entity/calculation_history.dart';
import '../../repository/calculation_history_repository.dart';
import '../use_case.dart';

class UpdateCalculationHistoryUseCase
    implements
        UseCase<Future<CalculationHistory>, UpdateCalculationHistoryParams> {
  final repository = GetIt.I<CalculationHistoryRepository>();

  @override
  Future<CalculationHistory> call(UpdateCalculationHistoryParams params) async {
    return await repository.update(
      id: params.id,
      calculationHistory: params.calculationHistory,
    );
  }
}

class UpdateCalculationHistoryParams {
  final int id;
  final CalculationHistory calculationHistory;

  UpdateCalculationHistoryParams({
    required this.id,
    required this.calculationHistory,
  });
}
