class Dog {
  final int id;
  final String name;
  final int age;

  Dog({this.id, this.name, this.age});

  factory Dog.fromDatabaseJson(Map<String, dynamic> data) {
    return Dog(id: data['id'], name: data['name'], age: data['age']);
  }

  Map<String, dynamic> toDatabaseJson() {
    return {
      "id": this.id,
      "name": this.name,
      "age": this.age,
    };
  }
}
