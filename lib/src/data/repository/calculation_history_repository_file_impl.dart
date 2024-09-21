import 'dart:convert';

import 'package:get_it/get_it.dart';

import '../../domain/entity/calculation_history.dart';
import '../../domain/repository/calculation_history_repository.dart';
import '../file/file_service.dart';

const String fileName = 'calculation_history.json';

class CalculationHistoryRepositoryFileImpl
    implements CalculationHistoryRepository {
  final fileService = GetIt.I<FileService>();

  @override
  Future<CalculationHistory> create({
    required CalculationHistory calculationHistory,
  }) async {
    late int id;
    List<CalculationHistory> calculationHistories = (await getAll()).toList();
    if (calculationHistories.isEmpty) {
      id = 1;
    } else {
      final lastCalculationHistory =
          calculationHistories.reduce((a, b) => a.id > b.id ? a : b);
      id = lastCalculationHistory.id + 1;
    }

    final newCalculationHistory = CalculationHistory(
      id: id,
      expression: calculationHistory.expression,
      result: calculationHistory.result,
    );
    calculationHistories.add(newCalculationHistory);
    final json = jsonEncode(calculationHistories);
    await fileService.write(fileName, json);

    return newCalculationHistory;
  }

  @override
  Future<void> delete({required int id}) async {
    List<CalculationHistory> calculationHistories = (await getAll()).toList();
    calculationHistories.removeWhere((e) => e.id == id);
    final json = jsonEncode(calculationHistories);
    await fileService.write(fileName, json);
  }

  @override
  Future<CalculationHistory> get({required int id}) async {
    // TODO: implement get
    throw UnimplementedError();
  }

  @override
  Future<Iterable<CalculationHistory>> getAll() async {
    String content =
        await fileService.read(fileName, defaultContentIfNotExists: '[]');
    content = content.trim();
    if (content.isEmpty) return [];

    final List<dynamic> jsons = jsonDecode(content);
    return jsons.map((json) => CalculationHistory.fromJson(json));
  }

  @override
  Future<CalculationHistory> update({
    required int id,
    required CalculationHistory calculationHistory,
  }) async {
    // TODO: implement update
    throw UnimplementedError();
  }
}
