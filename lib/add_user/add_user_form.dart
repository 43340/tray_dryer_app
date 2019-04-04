import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:tray_dryer_app/add_user/add_user.dart';

class AddUserForm extends StatefulWidget {
  final AddUserBloc addUserBloc;

  AddUserForm({
    Key key,
    @required this.addUserBloc,
  }) : super(key: key);

  @override
  State<AddUserForm> createState() => _AddUserFormState();
}

class _AddUserFormState extends State<AddUserForm> {
  final _userNameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  AddUserBloc get _addUserBloc => widget.addUserBloc;

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
    return BlocBuilder<AddUserEvent, AddUserState>(
      bloc: _addUserBloc,
      builder: (
        BuildContext context,
        AddUserState state,
      ) {
        if (state is AddUserFailure) {
          _onWidgetDidBuild(() {
            Scaffold.of(context).showSnackBar(
              SnackBar(
                content: Text('${state.error}'),
                backgroundColor: Colors.red,
              ),
            );
          });
        }

        return Form(
          child: Column(
            children: [
              TextFormField(
                decoration: InputDecoration(labelText: 'Username'),
                controller: _userNameController,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Password'),
                controller: _passwordController,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Confirm Password'),
                controller: _confirmPasswordController,
              ),
              RaisedButton(
                onPressed:
                    state is! AddUserLoading ? _onSubmitButtonPressed : null,
                child: Text('Submit'),
              )
            ],
          ),
        );
      },
    );
  }

  void _onWidgetDidBuild(Function callback) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      callback();
    });
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
      return;
    }

    if (_passwordController.text != _confirmPasswordController.text) {
      _showDialog('Error', 'Password dont match.');
      return;
    }

    String username = _userNameController.text;
    String password = _passwordController.text;

    Scaffold.of(context).showSnackBar(
      SnackBar(
        content: Text('Success'),
        backgroundColor: Colors.green,
      ),
    );

    _clearInputFields();

    _addUserBloc.dispatch(SubmitButtonPressed(
      username: username,
      password: password,
    ));
  }
}
