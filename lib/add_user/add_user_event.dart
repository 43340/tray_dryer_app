import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

abstract class AddUserEvent extends Equatable {
  AddUserEvent([List props = const []]) : super(props);
}

class SubmitButtonPressed extends AddUserEvent {
  final String username;
  final String password;

  /// Dispatched when the user press the submit button
  SubmitButtonPressed({@required this.username, @required this.password})
      : super([username, password]);

  @override
  String toString() =>
      'SubmitButtonPressed {name: $username, setTemperature: $password}';
}
