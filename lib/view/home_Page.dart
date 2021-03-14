import 'package:FlutterSQLite/controller/dog_controller.dart';
import 'package:FlutterSQLite/model/dog.dart';
import 'package:flutter/material.dart';

import '../controller/dog_controller.dart';
import 'dog_details.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final DogController dogController = DogController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("CRUD SQFlite"),
      ),
      body: _getBody(),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            heroTag: "btn1",
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DogDetails(
                    dog: null,
                  ),
                ),
              );
            },
            tooltip: 'Increment',
            child: Icon(Icons.add),
          ),
          SizedBox(
            height: 10,
          ),
          FloatingActionButton(
            heroTag: "btn2",
            onPressed: () => dogController.deleteAllDogs(),
            tooltip: 'Decrement',
            child: Icon(Icons.delete_forever),
          ),
        ],
      ),
    );
  }

  Widget _getBody() {
    return SafeArea(
      bottom: true,
      top: true,
      child: Column(
        children: <Widget>[
          new Container(
            color: Theme.of(context).primaryColor,
            child: new Padding(
              padding: const EdgeInsets.all(8.0),
              child: new Card(
                child: new ListTile(
                  leading: new Icon(Icons.search),
                  title: new TextField(
                    // controller: controller,
                    decoration: new InputDecoration(
                        hintText: 'Search', border: InputBorder.none),
                    onChanged: (String value) {
                      if (value.isNotEmpty) {
                        dogController.getDogs(query: value);
                      } else {
                        dogController.getDogs();
                      }
                    },
                  ),
                ),
              ),
            ),
          ),
          new Expanded(
            child: _getDogsWidget(),
          ),
        ],
      ),
    );
  }

  Widget _getDogsWidget() {
    dogController.getDogs();
    return StreamBuilder(
      stream: dogController.dogs,
      builder: (BuildContext context, AsyncSnapshot<List<Dog>> snapshot) {
        if (snapshot.hasData) {
          if (snapshot.data.length > 0) {
            return dogCard(context, snapshot.data);
          } else {
            return _noDogsContent();
          }
        } else {
          return loadingData();
        }
      },
    );
  }

  @override
  void dispose() {
    dogController.dispose();
    super.dispose();
  }

  Widget dogCard(BuildContext context, List<Dog> listDogs) {
    return Column(children: <Widget>[
      new Expanded(
        child: ListView.builder(
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          itemCount: listDogs.length,
          itemBuilder: (context, itemPosition) {
            Dog dog = listDogs[itemPosition];

            return _dogCard(context, dog);
          },
        ),
      ),
    ]);
  }

  Widget _noDogsContent() {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            "No data",
            style: TextStyle(fontSize: 40.0, fontWeight: FontWeight.bold),
          ),
          ClipOval(
            child: Image.asset(
              'assets/images/Dog1.jpg',
              height: 200,
              width: 200,
            ),
          ),
        ],
      ),
    );
  }

  Widget _dogCard(BuildContext context, Dog dog) {
    return Card(
      elevation: 10,
      shadowColor: Colors.green,
      shape: RoundedRectangleBorder(
        side: BorderSide(color: Colors.grey[200], width: 0.5),
        borderRadius: BorderRadius.circular(5),
      ),
      child: Row(
        children: <Widget>[
          Expanded(
            flex: 2,
            child: InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => DogDetails(dog: dog)));
              },
              child: Column(
                children: <Widget>[
                  _getLabel("ID", dog.id.toString()),
                  _getLabel("Name", dog.name.toString()),
                  _getLabel("Age", dog.age.toString()),
                ],
              ),
            ),
          ),
          IconButton(
            color: Colors.red,
            icon: Icon(Icons.delete),
            onPressed: () => dogController.deleteDogById(dog.id),
          ),
        ],
      ),
    );
  }

  Widget loadingData() {
    dogController.getDogs();
    return Container(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            CircularProgressIndicator(),
            Text("Loading...",
                style: TextStyle(fontSize: 19, fontWeight: FontWeight.w500))
          ],
        ),
      ),
    );
  }

  Widget _getLabel(String label, String value) {
    return Row(
      children: <Widget>[
        SizedBox(
          width: 50.0,
          child: Text(
            label,
            textAlign: TextAlign.center,
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: 17.0,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
