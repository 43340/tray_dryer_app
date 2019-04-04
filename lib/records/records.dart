import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:tray_dryer_app/home/home.dart';
import 'package:tray_dryer_app/models/process_model.dart';
import 'package:http/http.dart' as http;

class ProcessList extends StatefulWidget {
  final String title;

  ProcessList(this.title);

  @override
  _ProcessListState createState() => _ProcessListState();
}

class _ProcessListState extends State<ProcessList> {
  List<Process> list;

  @override
  void initState() {
    super.initState();
    this.getData();
  }

  Future<List<Process>> getData() async {
    final storage = new FlutterSecureStorage();

    String link;
    link = "http://192.168.254.102:8023/app/process";
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
        var rest = data["process"] as List;
        print(rest);
        list = rest.map<Process>((json) => Process.fromJson(json)).toList();
      }
    });
    print("List Size: ${list.length}");
    return list;
  }

  Widget listViewWidget(List<Process> process) {
    return Container(
      child: ListView.builder(
        padding: const EdgeInsets.all(2.0),
        itemBuilder: (context, position) {
          return Card(
            child: ListTile(
              title: Text(
                '${process[position].name}',
                style: TextStyle(
                  fontSize: 18.0,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
              onTap: () => _onTapItem(context, process[position]),
            ),
          );
        },
      ),
    );
  }

  void _onTapItem(BuildContext context, Process process) {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (BuildContext context) => HomePage()));
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
