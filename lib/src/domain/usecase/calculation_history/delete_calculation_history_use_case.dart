import 'package:get_it/get_it.dart';

import '../../repository/calculation_history_repository.dart';
import '../use_case.dart';

class DeleteCalculationHistoryUseCase implements UseCase<Future<void>, int> {
  final repository = GetIt.I<CalculationHistoryRepository>();

  @override
  Future<void> call(int id) async {
    return await repository.delete(id: id);
  }
}
