import 'package:flutter/material.dart';

import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tray_dryer_app/repository/data_repository/data_repository.dart';

import 'package:tray_dryer_app/data_input/data_input.dart';

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
  runApp(DataInputPage(dataRepository: DataRepository()));
}

class DataInputPage extends StatefulWidget {
  final DataRepository dataRepository;

  DataInputPage({Key key, @required this.dataRepository})
      : assert(dataRepository != null),
        super(key: key);

  @override
  State<DataInputPage> createState() => _DataInputPageState();
}

class _DataInputPageState extends State<DataInputPage> {
  DataInputBloc _dataInputBloc;

  DataRepository get _dataRepository => widget.dataRepository;

  @override
  void initState() {
    _dataInputBloc = DataInputBloc(dataRepository: _dataRepository);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('New Process'),
      ),
      body: DataInputForm(
        dataInputBloc: _dataInputBloc,
      ),
    );
  }

  @override
  void dispose() {
    _dataInputBloc.dispose();
    super.dispose();
  }
}
