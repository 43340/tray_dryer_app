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
            label: Text("Time",
                style: TextStyle(color: Colors.blue, fontSize: 14.0)),
            numeric: false,
            onSort: (i, b) {},
            tooltip: "Recorded Time",
          ),
          DataColumn(
            label: Text(
              "Average Temperature",
              style: TextStyle(color: Colors.red, fontSize: 14.0),
            ),
            numeric: false,
            onSort: (i, b) {},
            tooltip: "Recorded Temperature (Average)",
          ),
          DataColumn(
            label: Text(
              "Temperature (Chamber 1)",
              style: TextStyle(color: Colors.red, fontSize: 14.0),
            ),
            numeric: false,
            onSort: (i, b) {},
            tooltip: "Recorded Temperature (Chamber 1)",
          ),
          DataColumn(
            label: Text(
              "Temperature (Chamber 2)",
              style: TextStyle(color: Colors.red, fontSize: 14.0),
            ),
            numeric: false,
            onSort: (i, b) {},
            tooltip: "Recorded Temperature (Chamber 2)",
          ),
          DataColumn(
            label: Text(
              "Temperature (Chamber 3)",
              style: TextStyle(color: Colors.red, fontSize: 14.0),
            ),
            numeric: false,
            onSort: (i, b) {},
            tooltip: "Recorded Temperature (Chamber 3)",
          ),
          DataColumn(
            label: Text(
              "Humidity (Average)",
              style: TextStyle(color: Colors.green, fontSize: 14.0),
            ),
            numeric: false,
            onSort: (i, b) {},
            tooltip: "Recorded Humidity (Average)",
          ),
          DataColumn(
            label: Text(
              "Humidity (Chamber 1)",
              style: TextStyle(color: Colors.green, fontSize: 14.0),
            ),
            numeric: false,
            onSort: (i, b) {},
            tooltip: "Recorded Humidity (Chamber 1)",
          ),
          DataColumn(
            label: Text(
              "Humidity (Chamber 2)",
              style: TextStyle(color: Colors.green, fontSize: 14.0),
            ),
            numeric: false,
            onSort: (i, b) {},
            tooltip: "Recorded Humidity (Chamber 2)",
          ),
          DataColumn(
            label: Text(
              "Humidity (Chamber 3)",
              style: TextStyle(color: Colors.green, fontSize: 14.0),
            ),
            numeric: false,
            onSort: (i, b) {},
            tooltip: "Recorded Humidity (Chamber 4)",
          ),
        ],
        rows: details
            .map((detail) => DataRow(cells: [
                  DataCell(
                    Text(detail.timeStamp),
                    showEditIcon: false,
                    placeholder: false,
                  ),
                  DataCell(
                    Text(detail.temperature.toString()),
                    showEditIcon: false,
                    placeholder: false,
                  ),
                  DataCell(
                    Text(detail.temperature1.toString()),
                    showEditIcon: false,
                    placeholder: false,
                  ),
                  DataCell(
                    Text(detail.temperature2.toString()),
                    showEditIcon: false,
                    placeholder: false,
                  ),
                  DataCell(
                    Text(detail.temperature3.toString()),
                    showEditIcon: false,
                    placeholder: false,
                  ),
                  DataCell(
                    Text(detail.humidity.toString()),
                    showEditIcon: false,
                    placeholder: false,
                  ),
                  DataCell(
                    Text(detail.humidity1.toString()),
                    showEditIcon: false,
                    placeholder: false,
                  ),
                  DataCell(
                    Text(detail.humidity2.toString()),
                    showEditIcon: false,
                    placeholder: false,
                  ),
                  DataCell(
                    Text(detail.humidity3.toString()),
                    showEditIcon: false,
                    placeholder: false,
                  ),
                ]))
            .toList());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: list != null
            ? Center(child: SingleChildScrollView(child: tableData(list)))
            : Center(
                child: CircularProgressIndicator(),
              ),
      ),
    );
  }
}
