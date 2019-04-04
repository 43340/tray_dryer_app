import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:tray_dryer_app/data_input/data_input.dart';
import 'package:tray_dryer_app/add_user/add_user.dart';
import 'package:tray_dryer_app/records/records.dart';
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
                        builder: (context) => DataInputPage(
                              dataRepository: dataRepository,
                            )),
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
                        builder: (context) => AddUserPage(
                              newUserRepository: newUserRepository,
                            )),
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
