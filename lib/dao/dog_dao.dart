import 'package:FlutterSQLite/model/dog.dart';
import 'package:FlutterSQLite/database/database.dart';

class DogDao {
  final DatabaseProvider _database = DatabaseProvider.databaseProvider;

  static String table = "dogs";
  static String createTable =
      "CREATE TABLE dogs(id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT, age INTEGER)";

  Future<int> insertDog(Dog dog) async {
    final db = await _database.database;
    var result = db.insert(table, dog.toDatabaseJson());
    return result;
  }

  Future<List<Dog>> selectDogs({List<String> columns, String query}) async {
    final db = await _database.database;
    List<Map<String, dynamic>> result;

    if (query != null) {
      if (query.isNotEmpty) {
        result = await db.query(table,
            columns: columns, where: 'name like ?', whereArgs: ["%$query%"]);
      }
    } else {
      result = await db.query(table, columns: columns);
    }
    List<Dog> dogs = result.isNotEmpty
        ? result.map((dog) => Dog.fromDatabaseJson(dog)).toList()
        : [];

    return dogs;
  }

  Future<int> updateDog(Dog dog) async {
    final db = await _database.database;
    var result = await db.update(table, dog.toDatabaseJson(),
        where: "id = ? ", whereArgs: [dog.id]);

    return result;
  }

  Future<int> deleteDogById(int id) async {
    final db = await _database.database;
    var result = await db.delete(table, where: "id = ? ", whereArgs: [id]);

    return result;
  }

  Future<int> deleteDog(Dog dog) async {
    final db = await _database.database;
    var result = await db.delete(table, where: "id = ? ", whereArgs: [dog.id]);

    return result;
  }

  Future deleteAllDogs() async {
    final db = await _database.database;
    var result = await db.delete(table);

    return result;
  }
}
