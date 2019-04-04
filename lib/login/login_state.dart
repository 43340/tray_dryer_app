import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

abstract class LoginState extends Equatable {
  LoginState([List props = const []]) : super(props);
}

/// Initial State of login form
class LoginInitial extends LoginState {
  @override
  String toString() => 'LoginInitial';
}

/// State when validating credentials
class LoginLoading extends LoginState {
  @override
  String toString() => 'LoginLoading';
}

/// State when login attempt failed
class LoginFailure extends LoginState {
  final String error;

  LoginFailure({@required this.error}) : super([error]);

  @override
  String toString() => 'LoginFailure { error: $error }';
}
