import 'package:get_it/get_it.dart';

import '../../entity/calculation_history.dart';
import '../../repository/calculation_history_repository.dart';
import '../use_case.dart';

class GetCalculationHistoryUseCase
    implements UseCase<Future<CalculationHistory>, int> {
  final repository = GetIt.I<CalculationHistoryRepository>();

  @override
  Future<CalculationHistory> call(int id) async {
    return await repository.get(id: id);
  }
}
