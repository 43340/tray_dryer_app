import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

final String url = "http://192.168.254.102:8023/data";

class CurrentPage extends StatefulWidget {
  @override
  _CurrentPageState createState() => _CurrentPageState();
}

class _CurrentPageState extends State<CurrentPage> {
  StreamController _currentController;
  Timer _timer;

  Future getData() async {
    final response = await http.get(url);

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      print("Failed to get data.");
    }
  }

  loadData() async {
    getData().then((result) async {
      _currentController.add(result);
    });
  }

  @override
  void initState() {
    _currentController = new StreamController();
    _timer = new Timer.periodic(Duration(seconds: 1), (_) => loadData());
    super.initState();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        title: Text("Current Process"),
      ),
      body: StreamBuilder(
        stream: _currentController.stream,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            print("Exception: ${snapshot.error}");
          }

          if (snapshot.hasData) {
            var current = snapshot.data;
            var temp = current["temperature"] ?? "";
            var hum = current["humidity"] ?? "";
            var time = "0:00:00";

            return Column(
              children: <Widget>[
                ListTile(
                  title: Text("$temp", style: TextStyle(fontSize: 32)),
                ),
                ListTile(
                  title: Text("$hum", style: TextStyle(fontSize: 32)),
                ),
                ListTile(
                  title: Text("$time", style: TextStyle(fontSize: 32)),
                ),
              ],
            );
          }

          if (snapshot.connectionState != ConnectionState.waiting) {
            return new Center(
              child: new CircularProgressIndicator(),
            );
          }

          if (!snapshot.hasData &&
              snapshot.connectionState != ConnectionState.done) {
            return new Center(
              child: new CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
