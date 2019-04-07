import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import "package:tray_dryer_app/authentication/authentication.dart";
import 'package:tray_dryer_app/login/login.dart';

class LoginForm extends StatefulWidget {
  final LoginBloc loginBloc;
  final AuthenticationBloc authenticationBloc;

  LoginForm(
      {Key key, @required this.loginBloc, @required this.authenticationBloc})
      : super(key: key);

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  LoginBloc get _loginBloc => widget.loginBloc;

  void _onWidgetDidBuild(Function callback) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      callback();
    });
  }

  void _onLoginButtonPressed() {
    if (_usernameController.text.isNotEmpty &&
        _passwordController.text.isNotEmpty) {
      _loginBloc.dispatch(LoginButtonPressed(
        username: _usernameController.text,
        password: _passwordController.text,
      ));
    } else {
      _showDialog('Error',
          'Fields should not be empty.\nPlease check the username and password');
    }
  }

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

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginEvent, LoginState>(
      bloc: _loginBloc,
      builder: (
        BuildContext context,
        LoginState state,
      ) {
        if (state is LoginFailure) {
          _onWidgetDidBuild(
            () {
              Scaffold.of(context).showSnackBar(
                SnackBar(
                  content: Text('Invalid username or password'),
                  backgroundColor: Colors.red,
                ),
              );
            },
          );
        }

        return Form(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
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
                  controller: _usernameController,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
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
                  controller: _passwordController,
                  obscureText: true,
                ),
              ),
              RaisedButton(
                onPressed:
                    state is! LoginLoading ? _onLoginButtonPressed : null,
                child: Text('Login'),
              ),
              Container(
                child:
                    state is LoginLoading ? CircularProgressIndicator() : null,
              )
            ],
          ),
        );
      },
    );
  }
}
