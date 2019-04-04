import 'dart:async';

import 'package:meta/meta.dart';
import 'package:bloc/bloc.dart';
import 'package:tray_dryer_app/repository/data_repository/data_repository.dart';

import 'package:tray_dryer_app/data_input/data_input.dart';

class DataInputBloc extends Bloc<DataInputEvent, DataInputState> {
  final DataRepository dataRepository;

  DataInputBloc({
    @required this.dataRepository,
  }) : assert(dataRepository != null);

  DataInputState get initialState => DataInputInitial();

  @override
  Stream<DataInputState> mapEventToState(
      DataInputState currentState, DataInputEvent event) async* {
    if (event is SubmitButtonPressed) {
      yield DataInputLoading();

      try {
        await dataRepository.send(
          name: event.name,
          setTemperature: event.setTemperature,
          processTimer: event.processTimer,
          readInterval: event.readInterval,
        );

        yield DataInputInitial();
      } catch (error) {
        yield DataInputFailure(error: error.toString());
      }
    }
  }
}
