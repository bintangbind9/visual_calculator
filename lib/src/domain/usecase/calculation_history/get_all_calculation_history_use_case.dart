import 'package:get_it/get_it.dart';

import '../../entity/calculation_history.dart';
import '../../repository/calculation_history_repository.dart';
import '../use_case.dart';

class GetAllCalculationHistoryUseCase
    implements UseCase<Future<Iterable<CalculationHistory>>, void> {
  final repository = GetIt.I<CalculationHistoryRepository>();

  @override
  Future<Iterable<CalculationHistory>> call(void params) async {
    return await repository.getAll();
  }
}
