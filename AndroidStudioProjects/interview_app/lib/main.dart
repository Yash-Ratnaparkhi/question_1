import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() => runApp(
      MaterialApp(
        debugShowCheckedModeBanner: false,
        home: MyApp(),
      ),
    );

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // ignore: avoid_unnecessary_containers
    return Scaffold(
      backgroundColor: Colors.blue,
      body: Fetch(),
    );
  }
}

// ignore: use_key_in_widget_constructors
class Fetch extends StatefulWidget {
  @override
  _FetchState createState() => _FetchState();
}

class _FetchState extends State<Fetch> {
  // String x = "https://images.dog.ceo/breeds/entlebucher/n02108000_507.jpg";
  var image;
  Future<String> fetchData() async {
    var data =
        await http.get(Uri.parse("https://dog.ceo/api/breeds/image/random"));
    var jsonData = jsonDecode(data.body);

    image = jsonData["message"];

    print(jsonData["message"]);
    return jsonData["message"];
  }

  @override
  Widget build(BuildContext context) {
    // ignore: avoid_unnecessary_containers
    return Container(
        child: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            margin: EdgeInsets.fromLTRB(0.0, 0.0, 20.0, 0.0),
            child: FlatButton(
              child: Text(
                'refresh',
                style: TextStyle(fontSize: 20.0),
              ),
              color: Colors.red,
              textColor: Colors.white,
              onPressed: () {
                setState(() {
                  fetchData();
                });
              },
            ),
          ),
          Container(
            height: 200.0,
            width: 200.0,
            margin: EdgeInsets.only(top: 20.0, bottom: 20.0),
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(image == null
                    ? "https://images.dog.ceo/breeds/entlebucher/n02108000_507.jpg"
                    : image),
                fit: BoxFit.cover,
              ),
            ),
          ),
        ],
      ),
    ));
  }
}
