import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

import '../../common/exception/database_exception.dart';
import '../../domain/entity/calculation_history.dart';

const String dbName = 'visual_calculator.db';

class SqliteService {
  Database? _db;

  Future<String> _getPath() async {
    String databasesPath = await getDatabasesPath();
    String path = join(databasesPath, dbName);
    return path;
  }

  Future<void> _open() async {
    if (_db != null) {
      throw DatabaseAlreadyOpenException();
    }
    try {
      final dbPath = await _getPath();
      final db = await openDatabase(dbPath);
      _db = db;
      // Create CalculationHistory Table
      await db.execute(createCalculationHistoryTable);
    } on MissingPlatformDirectoryException {
      throw UnableToGetDocumentsDirectoryException();
    }
  }

  Future<void> close() async {
    final db = _db;
    if (db == null) {
      throw DatabaseIsNotOpenException();
    } else {
      await db.close();
      _db = null;
    }
  }

  Database getDatabaseOrThrow() {
    final db = _db;
    if (db == null) {
      throw DatabaseIsNotOpenException();
    } else {
      return db;
    }
  }

  Future<void> ensureDbIsOpen() async {
    try {
      await _open();
    } on DatabaseAlreadyOpenException {
      // empty
    }
  }
}
