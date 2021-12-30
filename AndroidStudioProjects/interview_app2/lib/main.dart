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
  var usd_rate;
  var gbp_rate;
  var eur_rate;
  var x;
  var answer;
  Future<int> fetchData(var x, int i) async {
    var data = await http
        .get(Uri.parse("https://api.coindesk.com/v1/bpi/currentprice.json"));
    var jsonData = jsonDecode(data.body);

    usd_rate = jsonData['bpi']['USD']['rate'];
    gbp_rate = jsonData['bpi']['GBP']['rate'];
    eur_rate = jsonData['bpi']['EUR']['rate'];

    print(gbp_rate);
    print(x);
    if (i == 1) {
      answer = x * usd_rate;
      // answer = x * double.parse(usd_rate);
      // print("11111111");
      // print(answer);
    }
    if (i == 2) {
      answer = double.parse(x * double.parse(gbp_rate));
    }
    if (i == 3) {
      answer = (x * double.parse(eur_rate));
    }
    // print(x * double.parse(usd_rate));
    return answer;
  }

  @override
  initState() {
    super.initState();
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
            margin: EdgeInsets.fromLTRB(120.0, 0.0, 120.0, 50.0),
            child: TextField(
              textAlign: TextAlign.center,
              keyboardType: TextInputType.emailAddress,
              onChanged: (value) {
                x = value;
              },
            ),
          ),
          Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  margin: const EdgeInsets.fromLTRB(0.0, 0.0, 20.0, 0.0),
                  child: FlatButton(
                    child: const Text(
                      'USD',
                      style: TextStyle(fontSize: 20.0),
                    ),
                    color: Colors.red,
                    textColor: Colors.white,
                    onPressed: () {
                      setState(() {
                        fetchData(x, 1);
                        answer = x * usd_rate;
                      });
                    },
                  ),
                ),
                Container(
                  margin: const EdgeInsets.fromLTRB(0.0, 0.0, 20.0, 0.0),
                  child: FlatButton(
                    child: const Text(
                      'GBP',
                      style: TextStyle(fontSize: 20.0),
                    ),
                    color: Colors.red,
                    textColor: Colors.white,
                    onPressed: () {
                      setState(() {
                        answer = x * double.parse(gbp_rate);
                      });
                    },
                  ),
                ),
                Container(
                  margin: const EdgeInsets.fromLTRB(0.0, 0.0, 20.0, 0.0),
                  child: FlatButton(
                    child: const Text(
                      'EURO ',
                      style: TextStyle(fontSize: 20.0),
                    ),
                    color: Colors.red,
                    textColor: Colors.white,
                    onPressed: () {
                      setState(() {
                        answer = x * double.parse(eur_rate);
                      });
                    },
                  ),
                ),
              ]),
          Container(
            margin: const EdgeInsets.fromLTRB(0.0, 100.0, 20.0, 0.0),
            child: FlatButton(
              child: Text(
                '$answer',
                style: const TextStyle(fontSize: 20.0),
              ),
              color: Colors.red,
              textColor: Colors.white,
              onPressed: () {
                setState(() {});
              },
            ),
          ),
        ],
      ),
    ));
  }
}
