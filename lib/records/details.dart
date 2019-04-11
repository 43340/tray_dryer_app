import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:tray_dryer_app/common/common.dart';
import 'package:tray_dryer_app/models/detail_model.dart';
import 'package:http/http.dart' as http;

class DetailsView extends StatefulWidget {
  final String title;
  final String processId;

  DetailsView(this.title, this.processId);

  _DetailsViewState createState() => _DetailsViewState(processId);
}

class _DetailsViewState extends State<DetailsView> {
  final String processId;
  List<Details> list;

  _DetailsViewState(this.processId);

  @override
  void initState() {
    super.initState();
    this.getData(processId);
  }

  Future<List<Details>> getData(processId) async {
    final storage = new FlutterSecureStorage();

    String link = "http://$BASE_URL:8023/data/$processId";
    String token = await storage.read(key: 'token');

    Map<String, String> headers = {
      'x-access-token': token,
    };

    var response = await http.get(link, headers: headers);

    print(response.body);

    setState(() {
      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        var rest = data as List;
        print(rest);
        list = rest.map<Details>((json) => Details.fromJson(json)).toList();
      }
    });
    print("List Size: ${list.length}");
    return list;
  }

  Widget tableData(List<Details> details) {
    return DataTable(
        columns: <DataColumn>[
          DataColumn(
            label: Text(
              "Temperature",
              style: TextStyle(color: Colors.red, fontSize: 14.0),
            ),
            numeric: false,
            onSort: (i, b) {},
            tooltip: "Recorded Temperature",
          ),
          DataColumn(
            label: Text(
              "Humidity",
              style: TextStyle(color: Colors.green, fontSize: 14.0),
            ),
            numeric: false,
            onSort: (i, b) {},
            tooltip: "Recorded Humidity",
          ),
          DataColumn(
            label: Text("Time",
                style: TextStyle(color: Colors.blue, fontSize: 14.0)),
            numeric: false,
            onSort: (i, b) {},
            tooltip: "Recorded Time",
          )
        ],
        rows: details
            .map((detail) => DataRow(cells: [
                  DataCell(
                    Text(detail.temperature.toString()),
                    showEditIcon: false,
                    placeholder: false,
                  ),
                  DataCell(
                    Text(detail.humidity.toString()),
                    showEditIcon: false,
                    placeholder: false,
                  ),
                  DataCell(
                    Text(detail.timeStamp),
                    showEditIcon: false,
                    placeholder: false,
                  )
                ]))
            .toList());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: list != null
          ? Center(child: SingleChildScrollView(child: tableData(list)))
          : Center(
              child: CircularProgressIndicator(),
            ),
    );
  }
}
