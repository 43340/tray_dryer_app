import 'dart:async';

import 'package:meta/meta.dart';
import 'package:bloc/bloc.dart';
import 'package:tray_dryer_app/repository/new_user_repository/new_user_repository.dart';

import 'package:tray_dryer_app/add_user/add_user.dart';

class AddUserBloc extends Bloc<AddUserEvent, AddUserState> {
  final NewUserRepository newUserRepository;

  AddUserBloc({
    @required this.newUserRepository,
  }) : assert(newUserRepository != null);

  AddUserState get initialState => AddUserInitial();

  @override
  Stream<AddUserState> mapEventToState(
      AddUserState currentState, AddUserEvent event) async* {
    if (event is SubmitButtonPressed) {
      yield AddUserLoading();

      try {
        await newUserRepository.send(
          username: event.username,
          password: event.password,
        );

        yield AddUserInitial();
      } catch (error) {
        yield AddUserFailure(error: error.toString());
      }
    }
  }
}
