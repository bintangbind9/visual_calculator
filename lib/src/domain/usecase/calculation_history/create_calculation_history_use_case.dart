import 'package:get_it/get_it.dart';

import '../../entity/calculation_history.dart';
import '../../repository/calculation_history_repository.dart';
import '../use_case.dart';

class CreateCalculationHistoryUseCase
    implements UseCase<Future<CalculationHistory>, CalculationHistory> {
  final repository = GetIt.I<CalculationHistoryRepository>();

  @override
  Future<CalculationHistory> call(CalculationHistory calculationHistory) async {
    return await repository.create(calculationHistory: calculationHistory);
  }
}
