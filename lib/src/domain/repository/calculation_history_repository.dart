import '../entity/calculation_history.dart';

abstract class CalculationHistoryRepository {
  Future<void> delete({required int id});

  Future<CalculationHistory> create({
    required CalculationHistory calculationHistory,
  });

  Future<CalculationHistory> get({required int id});

  Future<Iterable<CalculationHistory>> getAll();

  Future<CalculationHistory> update({
    required int id,
    required CalculationHistory calculationHistory,
  });
}
