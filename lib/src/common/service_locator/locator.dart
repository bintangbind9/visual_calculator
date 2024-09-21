import 'package:get_it/get_it.dart' show GetIt;

import '../../data/repository/calculation_history_repository_impl.dart';
import '../../data/sqlite/sqlite_service.dart';
import '../../domain/repository/calculation_history_repository.dart';
import '../../domain/usecase/calculation_history/create_calculation_history_use_case.dart';
import '../../domain/usecase/calculation_history/delete_calculation_history_use_case.dart';
import '../../domain/usecase/calculation_history/get_all_calculation_history_use_case.dart';
import '../../domain/usecase/calculation_history/get_calculation_history_use_case.dart';
import '../../domain/usecase/calculation_history/update_calculation_history_use_case.dart';
import '../util/calculator/calculator.dart';
import '../util/overlay/loading/loading_screen.dart';

void setupLocator() {
  // COMMON
  GetIt.I.registerSingleton<LoadingScreen>(LoadingScreen());
  GetIt.I.registerSingleton<Calculator>(Calculator());

  // SERVICES
  GetIt.I.registerSingleton<SqliteService>(SqliteService());

  // REPOSITORIES
  GetIt.I.registerSingleton<CalculationHistoryRepository>(
      CalculationHistoryRepositoryImpl());

  // USECASES
  GetIt.I.registerSingleton<CreateCalculationHistoryUseCase>(
      CreateCalculationHistoryUseCase());
  GetIt.I.registerSingleton<UpdateCalculationHistoryUseCase>(
      UpdateCalculationHistoryUseCase());
  GetIt.I.registerSingleton<DeleteCalculationHistoryUseCase>(
      DeleteCalculationHistoryUseCase());
  GetIt.I.registerSingleton<GetCalculationHistoryUseCase>(
      GetCalculationHistoryUseCase());
  GetIt.I.registerSingleton<GetAllCalculationHistoryUseCase>(
      GetAllCalculationHistoryUseCase());
}
