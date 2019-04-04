import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:tray_dryer_app/data_input/data_input.dart';

class DataInputForm extends StatefulWidget {
  final DataInputBloc dataInputBloc;

  DataInputForm({
    Key key,
    @required this.dataInputBloc,
  }) : super(key: key);

  @override
  State<DataInputForm> createState() => _DataInputFormState();
}

class _DataInputFormState extends State<DataInputForm> {
  final _nameController = TextEditingController();
  final _setTemperatureController = TextEditingController();
  final _processTimerHController = TextEditingController();
  final _processTimerMController = TextEditingController();
  final _processTimerSController = TextEditingController();
  final _readIntervalController = TextEditingController();

  DataInputBloc get _dataInputBloc => widget.dataInputBloc;

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
    return BlocBuilder<DataInputEvent, DataInputState>(
      bloc: _dataInputBloc,
      builder: (
        BuildContext context,
        DataInputState state,
      ) {
        if (state is DataInputFailure) {
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
                decoration: InputDecoration(labelText: 'Name'),
                controller: _nameController,
              ),
              TextFormField(
                  decoration: InputDecoration(labelText: 'Set Temperature'),
                  controller: _setTemperatureController,
                  keyboardType: TextInputType.number,
                  inputFormatters: <TextInputFormatter>[
                    WhitelistingTextInputFormatter.digitsOnly
                  ]),
              TextFormField(
                  decoration:
                      InputDecoration(labelText: 'Process Timer (Hours)'),
                  controller: _processTimerHController,
                  keyboardType: TextInputType.number,
                  inputFormatters: <TextInputFormatter>[
                    WhitelistingTextInputFormatter.digitsOnly
                  ]),
              TextFormField(
                  decoration:
                      InputDecoration(labelText: 'Process Timer (Minutes)'),
                  controller: _processTimerMController,
                  keyboardType: TextInputType.number,
                  inputFormatters: <TextInputFormatter>[
                    WhitelistingTextInputFormatter.digitsOnly
                  ]),
              TextFormField(
                  decoration:
                      InputDecoration(labelText: 'Process Timer (Seconds)'),
                  controller: _processTimerSController,
                  keyboardType: TextInputType.number,
                  inputFormatters: <TextInputFormatter>[
                    WhitelistingTextInputFormatter.digitsOnly
                  ]),
              TextFormField(
                  decoration: InputDecoration(labelText: 'Read Interval'),
                  controller: _readIntervalController,
                  keyboardType: TextInputType.number,
                  inputFormatters: <TextInputFormatter>[
                    WhitelistingTextInputFormatter.digitsOnly
                  ]),
              RaisedButton(
                onPressed:
                    state is! DataInputLoading ? _onSubmitButtonPressed : null,
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
    _nameController.text = '';
    _setTemperatureController.text = '';
    _processTimerHController.text = '';
    _processTimerMController.text = '';
    _processTimerSController.text = '';
    _readIntervalController.text = '';
  }

  _onSubmitButtonPressed() {
    if (_nameController.text.isEmpty ||
        _setTemperatureController.text.isEmpty ||
        _processTimerHController.text.isEmpty ||
        _processTimerMController.text.isEmpty ||
        _processTimerSController.text.isEmpty ||
        _readIntervalController.text.isEmpty) {
      _showDialog(
          'Error', 'Fields should not be empty.\nPlease fillup all the forms');
    }

    String name = _nameController.text;
    int setTemperature = int.parse(_setTemperatureController.text);
    int processTimerH = int.parse(_processTimerHController.text);
    int processTimerM = int.parse(_processTimerMController.text);
    int processTimerS = int.parse(_processTimerSController.text);
    int readInterval = int.parse(_readIntervalController.text);

    Scaffold.of(context).showSnackBar(
      SnackBar(
        content: Text('Success'),
        backgroundColor: Colors.green,
      ),
    );

    _clearInputFields();

    _dataInputBloc.dispatch(SubmitButtonPressed(
        name: name,
        setTemperature: setTemperature,
        processTimer: (((processTimerH * 60) * 60) +
            (processTimerM * 60) +
            processTimerS),
        readInterval: readInterval));
  }
}
