import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tray_dryer_app/authentication/authentication.dart';

void sessionExpired(context) {
  final AuthenticationBloc authenticationBloc =
      BlocProvider.of<AuthenticationBloc>(context);
  authenticationBloc.dispatch(LoggedOut());
  showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
            title: new Text("Error"),
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
