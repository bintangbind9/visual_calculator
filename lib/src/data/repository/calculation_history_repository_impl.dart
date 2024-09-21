import 'dart:developer';

import 'package:get_it/get_it.dart';

import '../../common/exception/database_exception.dart';
import '../../domain/entity/calculation_history.dart';
import '../../domain/repository/calculation_history_repository.dart';
import '../sqlite/sqlite_service.dart';

class CalculationHistoryRepositoryImpl implements CalculationHistoryRepository {
  final sqliteService = GetIt.I<SqliteService>();

  @override
  Future<void> delete({required int id}) async {
    await sqliteService.ensureDbIsOpen();
    final db = sqliteService.getDatabaseOrThrow();

    final deletedCount = await db.delete(
      calculationHistoryTable,
      where: '$idColumn = ?',
      whereArgs: [id],
    );
    if (deletedCount <= 0) {
      throw CouldNotDeleteCalculationHistoryException();
    }
  }

  @override
  Future<CalculationHistory> create({
    required CalculationHistory calculationHistory,
  }) async {
    await sqliteService.ensureDbIsOpen();
    final db = sqliteService.getDatabaseOrThrow();

    try {
      final id = await db.insert(
        calculationHistoryTable,
        calculationHistory.toJson(),
      );

      final result = CalculationHistory(
        id: id,
        expression: calculationHistory.expression,
        result: calculationHistory.result,
      );

      return result;
    } catch (e) {
      log(e.toString());
      throw CouldNotCreateCalculationHistoryException();
    }
  }

  @override
  Future<CalculationHistory> get({required int id}) async {
    await sqliteService.ensureDbIsOpen();
    final db = sqliteService.getDatabaseOrThrow();

    final calculationHistories = await db.query(
      calculationHistoryTable,
      limit: 1,
      where: '$idColumn = ?',
      whereArgs: [id],
    );

    if (calculationHistories.isEmpty) {
      throw CouldNotFindCalculationHistoryException();
    } else {
      final calculationHistory =
          CalculationHistory.fromJson(calculationHistories.first);
      return calculationHistory;
    }
  }

  @override
  Future<Iterable<CalculationHistory>> getAll() async {
    await sqliteService.ensureDbIsOpen();
    final db = sqliteService.getDatabaseOrThrow();

    final calculationHistories = await db.query(calculationHistoryTable);

    return calculationHistories
        .map((json) => CalculationHistory.fromJson(json));
  }

  @override
  Future<CalculationHistory> update({
    required int id,
    required CalculationHistory calculationHistory,
  }) async {
    await sqliteService.ensureDbIsOpen();
    final db = sqliteService.getDatabaseOrThrow();

    // Make sure CalculationHistory exists
    await get(id: id);

    // Update
    final updatedCount = await db.update(
      calculationHistoryTable,
      calculationHistory.toJson(),
      where: '$idColumn = ?',
      whereArgs: [id],
    );

    if (updatedCount > 0) {
      final updatedCalculationHistory = await get(id: id);
      return updatedCalculationHistory;
    } else {
      throw CouldNotUpdateCalculationHistoryException();
    }
  }
}
