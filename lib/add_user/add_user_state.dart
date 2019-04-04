import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

abstract class AddUserState extends Equatable {
  AddUserState([List props = const []]) : super(props);
}

/// State after the Data Input Page is opened
class AddUserInitial extends AddUserState {
  @override
  String toString() => 'AddUSerInitial';
}

/// State when sending the input to  the server
/// and when recieving response from the server
class AddUserLoading extends AddUserState {
  @override
  String toString() => 'AddUserLoading';
}

/// State when data input is successful
class AddUserSuccess extends AddUserState {
  @override
  String toString() => 'AddUserSuccess';
}

/// State when data input fails
class AddUserFailure extends AddUserState {
  final String error;

  AddUserFailure({@required this.error}) : super([error]);

  @override
  String toString() => 'AddUserFailure {error: $error}';
}
