import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tray_dryer_app/common/common.dart';

import 'package:tray_dryer_app/start_new/start_new.dart';
import 'package:tray_dryer_app/add_user/add_user.dart';
import 'package:tray_dryer_app/all_users/all_users.dart';
import 'package:tray_dryer_app/records/records.dart';
import 'package:tray_dryer_app/records/all_records.dart';
import 'package:tray_dryer_app/repository/data_repository/data_repository.dart';
import 'package:tray_dryer_app/repository/new_user_repository/new_user_repository.dart';
import 'package:tray_dryer_app/authentication/authentication.dart';
import 'package:tray_dryer_app/current/current.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final AuthenticationBloc authenticationBloc =
        BlocProvider.of<AuthenticationBloc>(context);

    DataRepository dataRepository = new DataRepository();
    NewUserRepository newUserRepository = new NewUserRepository();

    return Scaffold(
      drawer: new MyDrawer(),
      appBar: AppBar(
        title: Text('Home'),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            Container(
              child: RaisedButton(
                child: Text('Logout'),
                onPressed: () {
                  authenticationBloc.dispatch(LoggedOut());
                },
              ),
            ),
            Container(
              child: RaisedButton(
                child: Text('New Process'),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            StartNewProcess("Start New Process")),
                  );
                },
              ),
            ),
            Container(
              child: RaisedButton(
                child: Text('Records'),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ProcessList("Records")),
                  );
                },
              ),
            ),
            Container(
              child: RaisedButton(
                child: Text('Add User'),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => AddNewUser("Add User")),
                  );
                },
              ),
            ),
            Container(
              child: RaisedButton(
                child: Text('All Users'),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => UsersView("All Users")),
                  );
                },
              ),
            ),
            Container(
              child: RaisedButton(
                child: Text('All Processes'),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ProcessListAll("All Processes")),
                  );
                },
              ),
            ),
            /* Container(
              child: RaisedButton(
                child: Text('Current Process'),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => MyApp()),
                  );
                },
              ),
            ), */
          ],
        ),
      ),
    );
  }
}
