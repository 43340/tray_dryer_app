import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:tray_dryer_app/common/common.dart';

class StartNewProcess extends StatefulWidget {
  final String title;

  StartNewProcess(this.title);

  @override
  _StartNewProcessState createState() => _StartNewProcessState();
}

class _StartNewProcessState extends State<StartNewProcess> {
  final _nameController = TextEditingController();
  final _setTemperatureController = TextEditingController();
  final _processTimerHController = TextEditingController();
  final _processTimerMController = TextEditingController();
  final _processTimerSController = TextEditingController();
  final _readIntervalController = TextEditingController();

  void _showDialog(title, body) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: new Text(title),
            content: new Text(body),
            actions: <Widget>[
              new FlatButton(
                child: new Text("Close"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              )
            ],
          );
        });
  }

  Future<void> sendData({
    @required String name,
    @required int setTemperature,
    @required int processTimer,
    @required int readInterval,
  }) async {
    final storage = new FlutterSecureStorage();

    String token = await storage.read(key: 'token');
    final String url = "http://192.168.254.102:8023/process";
    Map<String, String> headers = {
      'x-access-token': token,
      'content-type': 'application/json'
    };

    Map<String, dynamic> body = {
      'name': name,
      'stemp': setTemperature,
      'ctime': processTimer,
      'rinte': readInterval
    };

    final response = await http.post(
      url,
      headers: headers,
      body: json.encode(body),
    );

    if (response.statusCode == 200) {
      _showDialog("Success", "Process started.");
    } else if (response.statusCode == 403) {
      _showDialog("Drying in progress",
          "Please wait for the drying to finish or stop the current process.");
    } else if (response.statusCode == 401) {
      sessionExpired(context);
    }
  }

  void _clearInputFields() {
    _nameController.text = '';
    _setTemperatureController.text = '';
    _processTimerHController.text = '';
    _processTimerMController.text = '';
    _processTimerSController.text = '';
    _readIntervalController.text = '';
  }

  _onSubmitButtonPressed() {
    if (_nameController.text.isEmpty ||
        _setTemperatureController.text.isEmpty ||
        _processTimerHController.text.isEmpty ||
        _processTimerMController.text.isEmpty ||
        _processTimerSController.text.isEmpty ||
        _readIntervalController.text.isEmpty) {
      _showDialog(
          'Error', 'Fields should not be empty.\nPlease fillup all the forms');
    }

    String name = _nameController.text;
    int setTemperature = int.parse(_setTemperatureController.text);
    int processTimerH = int.parse(_processTimerHController.text);
    int processTimerM = int.parse(_processTimerMController.text);
    int processTimerS = int.parse(_processTimerSController.text);
    int readInterval = int.parse(_readIntervalController.text);

    _clearInputFields();

    sendData(
        name: name,
        setTemperature: setTemperature,
        processTimer: (((processTimerH * 60) * 60) +
            (processTimerM * 60) +
            processTimerS),
        readInterval: readInterval);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Form(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Name',
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                      color: Colors.black,
                      width: 2.0,
                    )),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                      color: Colors.blueAccent,
                      width: 2.0,
                    )),
                  ),
                  controller: _nameController,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Set Temperature',
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                        color: Colors.black,
                        width: 2.0,
                      )),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                        color: Colors.blueAccent,
                        width: 2.0,
                      )),
                    ),
                    controller: _setTemperatureController,
                    keyboardType: TextInputType.number,
                    inputFormatters: <TextInputFormatter>[
                      WhitelistingTextInputFormatter.digitsOnly
                    ]),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Process Timer (Hours)',
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                        color: Colors.black,
                        width: 2.0,
                      )),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                        color: Colors.blueAccent,
                        width: 2.0,
                      )),
                    ),
                    controller: _processTimerHController,
                    keyboardType: TextInputType.number,
                    inputFormatters: <TextInputFormatter>[
                      WhitelistingTextInputFormatter.digitsOnly
                    ]),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Process Timer (Minutes)',
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                        color: Colors.black,
                        width: 2.0,
                      )),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                        color: Colors.blueAccent,
                        width: 2.0,
                      )),
                    ),
                    controller: _processTimerMController,
                    keyboardType: TextInputType.number,
                    inputFormatters: <TextInputFormatter>[
                      WhitelistingTextInputFormatter.digitsOnly
                    ]),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Process Timer (Seconds)',
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                        color: Colors.black,
                        width: 2.0,
                      )),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                        color: Colors.blueAccent,
                        width: 2.0,
                      )),
                    ),
                    controller: _processTimerSController,
                    keyboardType: TextInputType.number,
                    inputFormatters: <TextInputFormatter>[
                      WhitelistingTextInputFormatter.digitsOnly
                    ]),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Read Interval',
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                        color: Colors.black,
                        width: 2.0,
                      )),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                        color: Colors.blueAccent,
                        width: 2.0,
                      )),
                    ),
                    controller: _readIntervalController,
                    keyboardType: TextInputType.number,
                    inputFormatters: <TextInputFormatter>[
                      WhitelistingTextInputFormatter.digitsOnly
                    ]),
              ),
              RaisedButton(
                onPressed: _onSubmitButtonPressed,
                child: Text('Submit'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
