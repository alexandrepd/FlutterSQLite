import 'package:FlutterSQLite/controller/dog_controller.dart';
import 'package:FlutterSQLite/model/dog.dart';
import 'package:flutter/material.dart';

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
      body: Center(
        child: Column(
          children: <Widget>[
            getDogsWidget(),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => DogDetails(
                        dog: null,
                      )));
        },
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }

  Widget getDogsWidget() {
    return StreamBuilder(
      stream: dogController.dogs,
      builder: (BuildContext context, AsyncSnapshot<List<Dog>> snapshot) {
        return dogCard(snapshot);
      },
    );
  }

  @override
  void dispose() {
    dogController.dispose();
    super.dispose();
  }

  Widget dogCard(AsyncSnapshot<List<Dog>> snapshot) {
    if (snapshot.hasData) {
      if (snapshot.data.length != 0) {
        return ListView.builder(
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            itemCount: snapshot.data.length,
            itemBuilder: (context, itemPosition) {
              Dog dog = snapshot.data[itemPosition];

              return _dogCard(dog);
            });
      } else {
        return Text("No data");
      }
    } else {
      return Center(
        child: loadingData(),
      );
    }
  }

  Widget _dogCard(Dog dog) {
    return Card(
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
                  Row(
                    children: <Widget>[
                      Text("ID"),
                      Text(
                        dog.id.toString(),
                        style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      Text("Name"),
                      Text(
                        dog.name,
                        style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      Text("Age"),
                      Text(
                        dog.age.toString(),
                        style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
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
}
