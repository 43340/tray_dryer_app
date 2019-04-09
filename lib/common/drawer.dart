import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tray_dryer_app/add_user/add_user.dart';
import 'package:tray_dryer_app/all_users/all_users.dart';
import 'package:tray_dryer_app/authentication/authentication.dart';
import 'package:tray_dryer_app/home/home.dart';
import 'package:tray_dryer_app/records/all_records.dart';
import 'package:tray_dryer_app/records/records.dart';
import 'package:tray_dryer_app/start_new/start_new.dart';

class MyDrawer extends StatelessWidget {
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
          new ListTile(
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
          new ListTile(
            leading: new Icon(Icons.timer),
            title: new Text("Current Process"),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => StartNewProcess("Start New Process")),
              );
            },
          ),
          new ListTile(
            leading: Icon(Icons.folder),
            title: new Text("Records"),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ProcessList("Records")),
              );
            },
          ),
          new ExpansionTile(
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
                  title: Text("Manage Processes"),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              ProcessListAll("All Processes")),
                    );
                  },
                ),
              ),
            ],
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
