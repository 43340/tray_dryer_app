import 'package:equatable/equatable.dart';

abstract class AuthenticationState extends Equatable {}

/// Wait to see if user is authenticated or not
class AuthenticationUninitialized extends AuthenticationState {
  @override
  String toString() => 'AuthenticationUninitialized';
}

/// successfully authenticated
class AuthenticationAuthenticated extends AuthenticationState {
  @override
  String toString() => 'AuthenticationAuthenticated';
}

/// not authenticated
class AuthenticationUnauthenticated extends AuthenticationState {
  @override
  String toString() => 'AuthenticationUnauthenticated';
}

class AuthenticationFailure extends AuthenticationState {
  @override
  String toString() => 'AuthenticationFailure';
}

/// Wait to persist or delete token
class AuthenticationLoading extends AuthenticationState {
  @override
  String toString() => 'AuthenticationLoading';
}
