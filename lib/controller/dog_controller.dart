import 'dart:async';

import 'package:FlutterSQLite/model/dog.dart';
import 'package:FlutterSQLite/repository/dog_repository.dart';

class DogController {
  final _dogRepository = DogRepository();

  final _dogController = StreamController<List<Dog>>.broadcast();
  get dogs => _dogController.stream;

  getDogs({String query}) async {
    _dogController.sink.add(await _dogRepository.getAllDogs(query: query));
  }

  insertDog(Dog dog) {
    _dogRepository.insertDog(dog);
    getDogs();
  }

  updateDog(Dog dog) {
    _dogRepository.updateDog(dog);
    getDogs();
  }

  deleteDog(Dog dog) {
    _dogRepository.deleteDog(dog);
    getDogs();
  }

  deleteDogById(int id) {
    _dogRepository.deleteDogById(id);
    getDogs();
  }

  deleteAllDogs() {
    _dogRepository.deleteAllDogs();
    getDogs();
  }

  dispose() {
    _dogController.close();
  }
}
