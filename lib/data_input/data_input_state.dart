import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

abstract class DataInputState extends Equatable {
  DataInputState([List props = const []]) : super(props);
}

/// State after the Data Input Page is opened
class DataInputInitial extends DataInputState {
  @override
  String toString() => 'DataInputInitial';
}

/// State when sending the input to  the server
/// and when recieving response from the server
class DataInputLoading extends DataInputState {
  @override
  String toString() => 'DataInputLoading';
}

/// State when data input is successful
class DataInputSuccess extends DataInputState {
  @override
  String toString() => 'DataInputSuccess';
}

/// State when data input fails
class DataInputFailure extends DataInputState {
  final String error;

  DataInputFailure({@required this.error}) : super([error]);

  @override
  String toString() => 'DataInputFailure {error: $error}';
}
