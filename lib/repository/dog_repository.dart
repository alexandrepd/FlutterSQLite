import 'package:FlutterSQLite/dao/dog_dao.dart';
import 'package:FlutterSQLite/model/dog.dart';

class DogRepository {
  final dogDao = DogDao();

  Future<List<Dog>> getAllDogs({String query}) {
    return dogDao.selectDogs(query: query);
  }

  Future<int> insertDog(Dog dog) {
    return dogDao.insertDog(dog);
  }

  Future<int> updateDog(Dog dog) {
    return dogDao.updateDog(dog);
  }

  Future<int> deleteDogById(int id) {
    return dogDao.deleteDogById(id);
  }

  Future<int> deleteDog(Dog dog) {
    return dogDao.deleteDog(dog);
  }

  Future deleteAllDogs() {
    return dogDao.deleteAllDogs();
  }
}
