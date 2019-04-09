import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:tray_dryer_app/common/common.dart';

class AddNewUser extends StatefulWidget {
  final String title;

  AddNewUser(this.title);

  @override
  _AddNewUserState createState() => _AddNewUserState();
}

class _AddNewUserState extends State<AddNewUser> {
  final _userNameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

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

  Future<bool> sendData({
    @required String username,
    @required String password,
  }) async {
    final storage = new FlutterSecureStorage();

    String token = await storage.read(key: 'token');
    final String url = "http://192.168.254.102:8023/user";
    Map<String, String> headers = {
      'x-access-token': token,
      'content-type': 'application/json'
    };

    Map<String, dynamic> body = {
      'name': username,
      'password': password,
    };

    final response = await http.post(
      url,
      headers: headers,
      body: json.encode(body),
    );

    if (response.statusCode == 200) {
      _showDialog("Success", "New user added.");
    } else if (response.statusCode == 409) {
      _showDialog("User exists", "Please enter a different username.");
    } else if (response.statusCode == 401) {
      sessionExpired(context);
    }
  }

  void _clearInputFields() {
    _userNameController.text = '';
    _passwordController.text = '';
    _confirmPasswordController.text = '';
  }

  _onSubmitButtonPressed() {
    if (_userNameController.text.isEmpty ||
        _passwordController.text.isEmpty ||
        _confirmPasswordController.text.isEmpty) {
      _showDialog(
          'Error', 'Fields should not be empty.\nPlease fillup all the forms');
    }

    String username = _userNameController.text;
    String password = _passwordController.text;
    String confirmPassword = _passwordController.text;

    if (_passwordController.text != _confirmPasswordController.text) {
      _showDialog('Error', 'Password dont match.');
      return;
    }

    _clearInputFields();

    sendData(
      username: username,
      password: password,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: SingleChildScrollView(
        child: Form(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  autofocus: true,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    labelText: 'Username',
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
                  controller: _userNameController,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    labelText: 'Password',
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
                  obscureText: true,
                  controller: _passwordController,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    labelText: 'Confirm Password',
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
                  obscureText: true,
                  controller: _confirmPasswordController,
                ),
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
