import 'dart:async';

import 'package:meta/meta.dart';
import 'package:bloc/bloc.dart';
import 'package:tray_dryer_app/repository/user_repository/user_repository.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'package:tray_dryer_app/authentication/authentication.dart';
import 'package:tray_dryer_app/login/login.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final UserRepository userRepository;
  final AuthenticationBloc authenticationBloc;

  LoginBloc({
    @required this.userRepository,
    @required this.authenticationBloc,
  })  : assert(userRepository != null),
        assert(authenticationBloc != null);

  @override
  LoginState get initialState => LoginInitial();

  @override
  Stream<LoginState> mapEventToState(
      LoginState currentState, LoginEvent event) async* {
    if (event is LoginButtonPressed) {
      yield LoginLoading();

      try {
        final token = await userRepository.authenticate(
          username: event.username,
          password: event.password,
        );

        final storage = new FlutterSecureStorage();

        var toke = await storage.read(key: 'token');

        print('token is $toke');

        if (token == null) {
          authenticationBloc.dispatch(LoginFailed());
        }

        authenticationBloc.dispatch(LoggedIn(token: token));
        yield LoginInitial();
      } catch (error) {
        yield LoginFailure(error: error.toString());
      }
    }
  }
}
