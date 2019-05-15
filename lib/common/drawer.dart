import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:tray_dryer_app/add_user/add_user.dart';
import 'package:tray_dryer_app/all_users/all_users.dart';
import 'package:tray_dryer_app/authentication/authentication.dart';
import 'package:tray_dryer_app/current/current.dart';
import 'package:tray_dryer_app/home/home.dart';
import 'package:tray_dryer_app/records/all_records.dart';
import 'package:tray_dryer_app/records/records.dart';
import 'package:tray_dryer_app/start_new/start_new.dart';

class MyDrawer extends StatefulWidget {
  @override
  _MyDrawerState createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  var adminStatus = "";
  _getAdmin() async {
    final storage = new FlutterSecureStorage();
    final administrator = await storage.read(key: 'admin');
    return administrator;
  }

  @override
  void initState() {
    var admin = _getAdmin();

    admin.then((val) {
      print(val);
      adminStatus = val;
      setState(() {
        adminStatus = val;
      });
    });
    print("adminStatus");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final AuthenticationBloc authenticationBloc =
        BlocProvider.of<AuthenticationBloc>(context);

    return new Drawer(
      child: new ListView(
        children: <Widget>[
          /* new DrawerHeader(
            child: new Text("Tray Dryer Controller"),
            decoration: new BoxDecoration(
              color: Colors.blue,
            ),
          ), */
          new ListTile(
            leading: new Icon(Icons.home),
            title: new Text("Home"),
            onTap: () {
              /* Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => HomePage()),
              ); */
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: new Icon(Icons.add),
            title: new Text("New Process"),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => StartNewProcess("Start New Process")),
              );
            },
          ),
          ListTile(
            leading: new Icon(Icons.timer),
            title: new Text("Current Process"),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => CurrentPage()),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.folder),
            title: new Text("Records"),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ProcessList("Records")),
              );
            },
          ),
          (adminStatus == "true")
              ? new ExpansionTile(
                  leading: Icon(Icons.supervised_user_circle),
                  title: Text("Admin"),
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(left: 32),
                      child: ListTile(
                        leading: Icon(Icons.people),
                        title: Text("Manage Users"),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => UsersView("All Users")),
                          );
                        },
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 32),
                      child: ListTile(
                        leading: Icon(Icons.folder_open),
                        title: Text("Manage Records"),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    ProcessListAll("All Records")),
                          );
                        },
                      ),
                    ),
                  ],
                )
              : new ListTile(
                  leading: Icon(Icons.supervised_user_circle),
                  title: Text("Admin"),
                  enabled: false,
                ),
          new ListTile(
            leading: Icon(Icons.exit_to_app),
            title: new Text("Logout"),
            onTap: () {
              authenticationBloc.dispatch(LoggedOut());
            },
          ),
        ],
      ),
    );
  }
}
