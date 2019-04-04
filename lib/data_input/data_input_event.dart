import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

abstract class DataInputEvent extends Equatable {
  DataInputEvent([List props = const []]) : super(props);
}

class SubmitButtonPressed extends DataInputEvent {
  final String name;
  final int setTemperature;
  final int processTimer;
  final int readInterval;

  /// Dispatched when the user press the submit button
  SubmitButtonPressed({
    @required this.name,
    @required this.setTemperature,
    @required this.processTimer,
    @required this.readInterval,
  }) : super([name, setTemperature, processTimer, readInterval]);

  @override
  String toString() =>
      'SubmitButtonPressed {name: $name, setTemperature: $setTemperature, processTimer: $processTimer, readInterval: $readInterval}';
}
