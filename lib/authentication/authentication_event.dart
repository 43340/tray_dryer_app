import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

abstract class AuthenticationEvent extends Equatable {
  AuthenticationEvent([List props = const []]) : super(props);
}

/// Dispatched on first load
class AppStarted extends AuthenticationEvent {
  @override
  String toString() => 'AppStarted';
}

/// Dispatched on successful login
class LoggedIn extends AuthenticationEvent {
  final String token;

  LoggedIn({@required this.token}) : super([token]);

  @override
  String toString() => 'LoggedIn { token: $token }';
}

class LoginFailed extends AuthenticationEvent {
  @override
  String toString() => 'LoginFailed';
}

/// Dispatched on Successful logout
class LoggedOut extends AuthenticationEvent {
  @override
  String toString() => 'LoggedOut';
}
