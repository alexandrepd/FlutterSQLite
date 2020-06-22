import 'package:FlutterSQLite/controller/dog_controller.dart';
import 'package:FlutterSQLite/model/dog.dart';
import 'package:flutter/material.dart';

class DogDetails extends StatefulWidget {
  @override
  _DogDetailsState createState() => _DogDetailsState();
}

class _DogDetailsState extends State<DogDetails> {
  final DogController dogController = DogController();
  Dog dog;
  final _textId = TextEditingController();
  final _textName = TextEditingController();
  final _textAge = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Dog Details"),
      ),
      body: _getBody(),
    );
  }

  _getBody() {
    return Center(
      child: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              _getImage(null),
              _getTextField("Id", _textId),
              _getTextField("Name", _textName),
              _getTextField("Age", _textAge),
              _setSaveButton(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _getTextField(String label, TextEditingController controller) {
    return TextFormField(
      decoration: InputDecoration(labelText: label),
      controller: controller,
      validator: (_) {
        return _validateForm();
      },
    );
  }

  Widget _getImage(String image) {
    return Container(
      child: Image.network(
          'https://hips.hearstapps.com/hmg-prod.s3.amazonaws.com/images/german-shepherd-dog-1557314959.jpg?crop=0.615xw:1.00xh;0.197xw,0&resize=768:*'),
    );
  }

  Widget _setSaveButton() {
    return new RaisedButton(
      onPressed: () {
        if (_formKey.currentState.validate()) {
          _saveDog();
          Navigator.pop(context);
        }
      },
      textColor: Colors.white,
      color: Colors.red,
      padding: const EdgeInsets.all(8.0),
      child: new Text(
        "Save",
      ),
    );
  }

  _validateForm() {
    if (_textId.value.text == null) {
      print('id invalido');
      return;
    }

    if (_textName.value.text == null) {
      print('Name invalido');
      return;
    }

    if (_textAge.value.text == null) {
      print('age invalido');
      return;
    }

    return null;
  }

  _saveDog() {
    var id = int.parse(_textId.value.text);
    var name = _textName.value.text;
    var age = int.parse(_textAge.value.text);

    dog = Dog(id: id, name: name, age: age);

    dogController.insertDog(dog);
  }
}
