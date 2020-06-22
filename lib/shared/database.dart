import 'package:FlutterSQLite/dao/dog_dao.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseProvider {
  static final DatabaseProvider databaseProvider = DatabaseProvider();
  Database _db;

  Future<Database> get database async {
    if (_db != null) return _db;

    _db = await _createDatabase();

    return _db;
  }

  Future<Database> _createDatabase() async {
    final String databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'doggie_database.db');
    return await openDatabase(path, version: 1, onCreate: _initDB);
  }

  void _initDB(Database database, int version) async {
    await database.execute(DogDao.createTable);
  }
}
