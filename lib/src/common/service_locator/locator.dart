import 'package:get_it/get_it.dart' show GetIt;

import '../../data/file/file_service.dart';
import '../../data/repository/calculation_history_repository_file_impl.dart';
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
  GetIt.I.registerSingleton<FileService>(FileService());

  // REPOSITORIES

  // USECASES
}

Future<void> setupLocatorStorageTypeDatabase() async {
  if (GetIt.I.isRegistered<CalculationHistoryRepository>()) {
    await GetIt.I.unregister<CalculationHistoryRepository>();
  }
  GetIt.I.registerSingleton<CalculationHistoryRepository>(
      CalculationHistoryRepositoryImpl());
}

Future<void> setupLocatorStorageTypeFile() async {
  if (GetIt.I.isRegistered<CalculationHistoryRepository>()) {
    await GetIt.I.unregister<CalculationHistoryRepository>();
  }
  GetIt.I.registerSingleton<CalculationHistoryRepository>(
      CalculationHistoryRepositoryFileImpl());
}

Future<void> setupLocatorCalculationHistoryUseCase() async {
  if (GetIt.I.isRegistered<CreateCalculationHistoryUseCase>()) {
    await GetIt.I.unregister<CreateCalculationHistoryUseCase>();
  }
  if (GetIt.I.isRegistered<UpdateCalculationHistoryUseCase>()) {
    await GetIt.I.unregister<UpdateCalculationHistoryUseCase>();
  }
  if (GetIt.I.isRegistered<DeleteCalculationHistoryUseCase>()) {
    await GetIt.I.unregister<DeleteCalculationHistoryUseCase>();
  }
  if (GetIt.I.isRegistered<GetCalculationHistoryUseCase>()) {
    await GetIt.I.unregister<GetCalculationHistoryUseCase>();
  }
  if (GetIt.I.isRegistered<GetAllCalculationHistoryUseCase>()) {
    await GetIt.I.unregister<GetAllCalculationHistoryUseCase>();
  }

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
