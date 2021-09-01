import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' show get;
import 'package:pics/src/models/image_model.dart';
import 'package:pics/src/widgets/image_list.dart';

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return MyAppState();
  }
}

class MyAppState extends State<MyApp> {
  int counter = 0;
  List<ImageModel> images = [];

  void _incrementCounter() {
    // setState(() {
    //   counter++;
    // });
    counter++;
  }

  void fetchImage() {
    // https://jsonplaceholder.typicode.com/photos/1
    var response;
    get(Uri.parse('https://jsonplaceholder.typicode.com/photos/$counter'))
        .then((serverResponse) {
      response = serverResponse;

      ImageModel imageModel =
          new ImageModel.fromJson(json.decode(response.body));

      setState(() {
        images.add(imageModel);
      });
    });
  }

  // void fetchImage() async {
  //   // https://jsonplaceholder.typicode.com/photos/1
  //   var response = await get(
  //       Uri.parse('https://jsonplaceholder.typicode.com/photos/$counter'));

  //   ImageModel imageModel = new ImageModel.fromJson(json.decode(response.body));

  //   setState(() {
  //     images.add(imageModel);
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("Hello world!"),
        ),
        body: ImageList(images),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            // print('General Kenobi');
            _incrementCounter();
            fetchImage();
          },
          child: Icon(Icons.add),
        ),
      ),
    );
  }
}
