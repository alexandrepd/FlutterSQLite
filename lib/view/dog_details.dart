import 'package:FlutterSQLite/controller/dog_controller.dart';
import 'package:FlutterSQLite/model/dog.dart';
import 'package:FlutterSQLite/view/home_Page.dart';
import 'package:flutter/material.dart';

class DogDetails extends StatefulWidget {
  final Dog dog;

  DogDetails({this.dog});
  @override
  _DogDetailsState createState() => _DogDetailsState();
}

class _DogDetailsState extends State<DogDetails> {
  final DogController dogController = DogController();
  bool isUpdate = false;
  Dog dog;
  final _textId = TextEditingController();
  final _textName = TextEditingController();
  final _textAge = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    isUpdate = widget.dog != null;
    return Scaffold(
      appBar: AppBar(
        title: Text("Dog Details"),
      ),
      body: _getBody(),
    );
  }

  _getBody() {
    return SingleChildScrollView(
      child: Form(
        key: _formKey,
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.all(10.0),
            child: Column(
              children: <Widget>[
                _getTextField("Id", _textId, widget.dog?.id),
                _getTextField("Name", _textName, widget.dog?.name),
                _getTextField("Age", _textAge, widget.dog?.age),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    _setSaveButton(),
                    Padding(
                      padding: EdgeInsets.all(5),
                    ),
                    _setDeleteButton(),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _getTextField(
      String label, TextEditingController controller, dynamic value) {
    if (value == null)
      controller.text = '';
    else
      controller.text = value.toString();

    return TextFormField(
      keyboardType: label == 'Id' || label == 'Age'
          ? TextInputType.number
          : TextInputType.text,
      decoration: InputDecoration(
        labelText: label,
      ),
      controller: controller,
      validator: (_) {
        return _validateForm();
      },
    );
  }

  Widget _setSaveButton() {
    return new RaisedButton(
      onPressed: () {
        if (_formKey.currentState.validate()) {
          _saveDog();
          _setBack();
        }
      },
      textColor: Colors.white,
      color: Colors.red,
      padding: const EdgeInsets.all(8.0),
      child: new Text(
        isUpdate ? "update" : "Save",
      ),
    );
  }

  Widget _setDeleteButton() {
    return new RaisedButton(
      onPressed: () {
        if (isUpdate) {
          dogController.deleteDogById(widget.dog.id);
          _setBack();
        }
      },
      textColor: Colors.white,
      color: Colors.red,
      padding: const EdgeInsets.all(8.0),
      child: new Text("Delete"),
    );
  }

  _validateForm() {
    // if (_textId.value.text == null) {
    //   print('id invalido');
    //   return;
    // }

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
    var name = _textName.value.text;
    var age = int.parse(_textAge.value.text);

    if (isUpdate) {
      var id = int.parse(_textId.value.text);
      dog = Dog(id: id, name: name, age: age);
      dogController.updateDog(dog);
    } else {
      dog = Dog(name: name, age: age);
      dogController.insertDog(dog);
    }
  }

  _setBack() {
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => HomePage()),
        (Route<dynamic> route) => false);
  }
}
