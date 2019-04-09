import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:tray_dryer_app/add_user/add_user.dart';
import 'package:tray_dryer_app/authentication/authentication.dart';
import 'package:tray_dryer_app/models/users_model.dart';
import 'package:http/http.dart' as http;

class UsersView extends StatefulWidget {
  final String title;

  UsersView(this.title);

  _UsersViewState createState() => _UsersViewState();
}

class _UsersViewState extends State<UsersView> {
  List<Users> list;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    this.getData();
  }

  Future<List<Users>> getData() async {
    final storage = new FlutterSecureStorage();
    String token = await storage.read(key: 'token');

    String link = "http://192.168.254.102:8023/user";

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
        list = rest.map<Users>((json) => Users.fromJson(json)).toList();
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

  Future<void> deleteUser(userId) async {
    final storage = new FlutterSecureStorage();
    String token = await storage.read(key: 'token');

    String link = "http://192.168.254.102:8023/user/$userId";

    Map<String, String> headers = {
      'x-access-token': token,
    };

    var response = await http.delete(
      link,
      headers: headers,
    );
  }

  Widget usersViewList(List<Users> users) {
    return Container(
      child: ListView.builder(
        itemCount: users.length,
        padding: const EdgeInsets.all(2.0),
        itemBuilder: (BuildContext context, int index) {
          return Card(
            child: ListTile(
              title: Text(
                '${users[index].name}',
                style: TextStyle(
                    fontSize: 18.0,
                    color: Colors.black,
                    fontWeight: FontWeight.bold),
              ),
              subtitle: Text(
                  "Admin: ${users[index].admin}\nID: ${users[index].publicId}"),
              leading: Icon(Icons.person),
              trailing: IconButton(
                icon: Icon(Icons.delete_forever),
                onPressed: () async {
                  bool shouldUpdate = await showDialog(
                      context: this.context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                            title: new Text("Delete User"),
                            content: new Text(
                                "Are you sure you want to delete user ${users[index].name}?"),
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
                                  deleteUser(users[index].publicId);
                                  Navigator.pop(context, true);
                                },
                              ),
                            ]);
                      });
                  setState(() {
                    shouldUpdate == true && shouldUpdate != null
                        ? users.remove(users[index])
                        : null;
                  });
                  if (shouldUpdate == true && shouldUpdate != null) {
                    Scaffold.of(context).showSnackBar(SnackBar(
                      content: Text("Deleted!"),
                      backgroundColor: Colors.green,
                    ));
                  }
                },
              ),
            ),
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: list != null
          ? usersViewList(list)
          : Center(
              child: CircularProgressIndicator(),
            ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.person_add),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddNewUser("Add User")),
          );
        },
      ),
    );
  }
}
