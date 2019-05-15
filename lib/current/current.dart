import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:tray_dryer_app/common/common.dart';
import 'package:tray_dryer_app/start_new/start_new.dart';

final String url = "http://$BASE_URL:8023/data";

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
            var temp1 = current["temperature1"] ?? "";
            var temp2 = current["temperature2"] ?? "";
            var temp3 = current["temperature3"] ?? "";
            var hum = current["humidity"] ?? "";
            var hum1 = current["humidity1"] ?? "";
            var hum2 = current["humidity2"] ?? "";
            var hum3 = current["humidity3"] ?? "";
            var time = current["timeleft"] ?? "";
            var stop = current["stop"] ?? "";

            if (stop) {
              return Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      "No running process",
                      style: TextStyle(fontSize: 32),
                    ),
                    FlatButton(
                      color: Colors.greenAccent[700],
                      child: Text("Start New"),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  StartNewProcess("Start New Process")),
                        );
                      },
                    ),
                    FlatButton(
                      color: Colors.greenAccent[700],
                      child: Text("Redo Last"),
                      onPressed: () async {
                        final storage = new FlutterSecureStorage();
                        String token = await storage.read(key: 'token');

                        String link = "http://$BASE_URL:8023/process/reset";

                        Map<String, String> headers = {
                          'x-access-token': token,
                        };

                        await http.get(link, headers: headers);
                      },
                    )
                  ],
                ),
              );
            } else {
              return SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    ExpansionTile(
                        title: Text("Temperature",
                            style:
                                TextStyle(fontSize: 24, color: Colors.black)),
                        children: <Widget>[
                          Card(
                            color: const Color(0xFF26c6da),
                            child: ListTile(
                              title: Text("Average Temperature",
                                  style: TextStyle(
                                      fontSize: 24, color: Colors.white)),
                              subtitle: Center(
                                  /* child: Text("${temp.toString().substring(0, 5)} °C", */
                                  child: Text(
                                      "${num.parse(temp).toStringAsFixed(2)} °C",
                                      style: TextStyle(
                                          fontSize: 48, color: Colors.white))),
                            ),
                          ),
                          Card(
                            color: const Color(0xFF26c6da),
                            child: ListTile(
                              title: Text("Temperature (Sensor 1)",
                                  style: TextStyle(
                                      fontSize: 24, color: Colors.white)),
                              subtitle: Center(
                                  /* child: Text("${temp.toString().substring(0, 5)} °C", */
                                  child: Text(
                                      "${num.parse(temp1).toStringAsFixed(2)} °C",
                                      style: TextStyle(
                                          fontSize: 48, color: Colors.white))),
                            ),
                          ),
                          Card(
                            color: const Color(0xFF26c6da),
                            child: ListTile(
                              title: Text("Temperature (Sensor 2)",
                                  style: TextStyle(
                                      fontSize: 24, color: Colors.white)),
                              subtitle: Center(
                                  /* child: Text("${temp.toString().substring(0, 5)} °C", */
                                  child: Text(
                                      "${num.parse(temp2).toStringAsFixed(2)} °C",
                                      style: TextStyle(
                                          fontSize: 48, color: Colors.white))),
                            ),
                          ),
                          Card(
                            color: const Color(0xFF26c6da),
                            child: ListTile(
                              title: Text("Temperature (Sensor 3)",
                                  style: TextStyle(
                                      fontSize: 24, color: Colors.white)),
                              subtitle: Center(
                                  /* child: Text("${temp.toString().substring(0, 5)} °C", */
                                  child: Text(
                                      "${num.parse(temp3).toStringAsFixed(2)} °C",
                                      style: TextStyle(
                                          fontSize: 48, color: Colors.white))),
                            ),
                          ),
                        ]),
                    ExpansionTile(
                        title: Text("Humidity",
                            style:
                                TextStyle(fontSize: 24, color: Colors.black)),
                        children: <Widget>[
                          Card(
                            color: const Color(0xFF26da86),
                            child: ListTile(
                              title: Text("Average Humidity",
                                  style: TextStyle(
                                      fontSize: 24, color: Colors.white)),
                              subtitle: Center(
                                  /* child: Text("${hum.toString().substring(0, 5)} %", */
                                  child: Text(
                                      "${num.parse(hum).toStringAsFixed(2)} %",
                                      style: TextStyle(
                                          fontSize: 48, color: Colors.white))),
                            ),
                          ),
                          Card(
                            color: const Color(0xFF26da86),
                            child: ListTile(
                              title: Text("Humidity (Sensor 1)",
                                  style: TextStyle(
                                      fontSize: 24, color: Colors.white)),
                              subtitle: Center(
                                  /* child: Text("${hum.toString().substring(0, 5)} %", */
                                  child: Text(
                                      "${num.parse(hum1).toStringAsFixed(2)} %",
                                      style: TextStyle(
                                          fontSize: 48, color: Colors.white))),
                            ),
                          ),
                          Card(
                            color: const Color(0xFF26da86),
                            child: ListTile(
                              title: Text("Humidity (Sensor 2)",
                                  style: TextStyle(
                                      fontSize: 24, color: Colors.white)),
                              subtitle: Center(
                                  /* child: Text("${hum.toString().substring(0, 5)} %", */
                                  child: Text(
                                      "${num.parse(hum2).toStringAsFixed(2)} %",
                                      style: TextStyle(
                                          fontSize: 48, color: Colors.white))),
                            ),
                          ),
                          Card(
                            color: const Color(0xFF26da86),
                            child: ListTile(
                              title: Text("Humidity (Sensor 3)",
                                  style: TextStyle(
                                      fontSize: 24, color: Colors.white)),
                              subtitle: Center(
                                  /* child: Text("${hum.toString().substring(0, 5)} %", */
                                  child: Text(
                                      "${num.parse(hum3).toStringAsFixed(2)} %",
                                      style: TextStyle(
                                          fontSize: 48, color: Colors.white))),
                            ),
                          ),
                        ]),
                    ExpansionTile(
                        initiallyExpanded: true,
                        title: Text("Timer",
                            style:
                                TextStyle(fontSize: 24, color: Colors.black)),
                        children: <Widget>[
                          Card(
                            color: const Color(0xFFda2636),
                            child: ListTile(
                              title: Text("Time",
                                  style: TextStyle(
                                      fontSize: 24, color: Colors.white)),
                              subtitle: Center(
                                  child: Text(
                                      "${Duration(seconds: (time - 2)).toString().padLeft(15, '0').substring(0, 8)}",
                                      style: TextStyle(
                                          fontSize: 48, color: Colors.white))),
                            ),
                          ),
                        ]),
                    FlatButton(
                      color: Colors.red,
                      textColor: Colors.white,
                      child: Text("Stop"),
                      onPressed: () async {
                        print("Woot");
                        await http.get("http://$BASE_URL:8023/stop");
                      },
                    )
                  ],
                ),
              );
            }
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
