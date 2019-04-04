import 'package:flutter/material.dart';

import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tray_dryer_app/repository/new_user_repository/new_user_repository.dart';

import 'package:tray_dryer_app/add_user/add_user.dart';

class SimpleBlocDelegate extends BlocDelegate {
  @override
  void onTransition(Transition transition) {
    print(transition.toString());
  }

  @override
  void onError(Object error, StackTrace stacktrace) {
    print(error);
  }
}

void main() {
  BlocSupervisor().delegate = SimpleBlocDelegate();
  runApp(AddUserPage(newUserRepository: NewUserRepository()));
}

class AddUserPage extends StatefulWidget {
  final NewUserRepository newUserRepository;

  AddUserPage({Key key, @required this.newUserRepository})
      : assert(newUserRepository != null),
        super(key: key);

  @override
  State<AddUserPage> createState() => _AddUserPageState();
}

class _AddUserPageState extends State<AddUserPage> {
  AddUserBloc _addUserBloc;

  NewUserRepository get _newUserRepository => widget.newUserRepository;

  @override
  void initState() {
    _addUserBloc = AddUserBloc(newUserRepository: _newUserRepository);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('New Process'),
      ),
      body: AddUserForm(
        addUserBloc: _addUserBloc,
      ),
    );
  }

  @override
  void dispose() {
    _addUserBloc.dispose();
    super.dispose();
  }
}
