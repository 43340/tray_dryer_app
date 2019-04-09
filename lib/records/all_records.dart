import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:tray_dryer_app/common/common.dart';
import 'package:tray_dryer_app/models/process_model.dart';
import 'package:http/http.dart' as http;
import 'package:tray_dryer_app/records/details.dart';
import 'package:tray_dryer_app/authentication/authentication.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProcessListAll extends StatefulWidget {
  final String title;

  ProcessListAll(this.title);

  @override
  _ProcessListAllState createState() => _ProcessListAllState();
}

class _ProcessListAllState extends State<ProcessListAll> {
  List<Process> list;

  @override
  void initState() {
    super.initState();
    this.getData();
  }

  Future<List<Process>> getData() async {
    final storage = new FlutterSecureStorage();

    String link;
    link = "http://192.168.254.102:8023/process/admin";
    String token = await storage.read(key: 'token');

    Map<String, String> headers = {
      'x-access-token': token,
    };

    var response = await http.get(
      link,
      headers: headers,
    );

    print(response.body);

    setState(() {
      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        var rest = data as List;
        print(rest);
        list = rest.map<Process>((json) => Process.fromJson(json)).toList();
        print("List Size: ${list.length}");
        return list;
      } else {
        final AuthenticationBloc authenticationBloc =
            BlocProvider.of<AuthenticationBloc>(context);
        authenticationBloc.dispatch(LoggedOut());
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                  title: new Text("Delete data?"),
                  content: new Text("Session Expired. Please login again."),
                  actions: <Widget>[
                    new FlatButton(
                      child: new Text("Ok"),
                      onPressed: () {
                        Navigator.of(context).pop();
                        Navigator.of(context).pop();
                      },
                    ),
                  ]);
            });
      }
    });
  }

  Future<void> deleteData(processId) async {
    final storage = new FlutterSecureStorage();
    String token = await storage.read(key: 'token');

    String link = "http://192.168.254.102:8023/process/$processId";

    Map<String, String> headers = {
      'x-access-token': token,
    };

    var response = await http.delete(
      link,
      headers: headers,
    );
  }

  Widget listViewWidget(List<Process> process) {
    return Container(
      child: ListView.builder(
        itemCount: process.length,
        padding: const EdgeInsets.all(2.0),
        itemBuilder: (context, position) {
          return Card(
            child: ExpansionTile(
              title: Text(
                '${process[position].name}',
                style: TextStyle(
                  fontSize: 18.0,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: new Text("User: ${process[position].userId}"),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: new Text(
                              "Temperature: ${process[position].setTemp}°C"),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: new Text(
                              "Timer: ${process[position].cookTime} seconds"),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: new Text(
                              "Interval: ${process[position].readInt} seconds"),
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: new IconButton(
                            icon: Icon(Icons.delete_forever),
                            iconSize: 30.0,
                            onPressed: () async {
                              bool shouldUpdate = await showDialog(
                                  context: this.context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                        title: new Text("Delete data?"),
                                        content: new Text(
                                            "Are you sure you want to delete the data ${process[position].name}"),
                                        actions: <Widget>[
                                          new FlatButton(
                                            child: new Text("Cancel"),
                                            onPressed: () {
                                              Navigator.pop(context, false);
                                            },
                                          ),
                                          new FlatButton(
                                            child: new Text("Confirm"),
                                            onPressed: () {
                                              deleteData(
                                                  process[position].processId);
                                              Navigator.pop(context, true);
                                            },
                                          ),
                                        ]);
                                  });
                              setState(() {
                                shouldUpdate == true && shouldUpdate != null
                                    ? process.remove(process[position])
                                    : null;
                              });
                              if (shouldUpdate == true &&
                                  shouldUpdate != null) {
                                Scaffold.of(context).showSnackBar(SnackBar(
                                  content: Text("Deleted!"),
                                  backgroundColor: Colors.green,
                                ));
                              }
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: new IconButton(
                            icon: Icon(Icons.keyboard_arrow_right),
                            iconSize: 30.0,
                            tooltip: "Open details",
                            onPressed: () => _onTapItem(
                                context,
                                process[position],
                                process[position].processId,
                                process[position].name),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  void _onTapItem(
      BuildContext context, Process process, String processId, String name) {
    Navigator.of(context).push(MaterialPageRoute(
        builder: (BuildContext context) => DetailsView(name, processId)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.title)),
      body: list != null
          ? listViewWidget(list)
          : Center(
              child: CircularProgressIndicator(),
            ),
    );
  }
}
