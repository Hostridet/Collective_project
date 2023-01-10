import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../repository/AuthRepository.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthRepository _authRepository;
  AuthBloc(this._authRepository) : super(AuthInitial()) {
    on<AuthLoginEvent>((event, emit) async {
      emit(AuthLoading());
      if (event.login.isEmpty || event.password.isEmpty) {
        emit(AuthEmptyError());
      }
      else {
        bool flag = await _authRepository.getAuth(event.login, event.password);
        if (flag == true) {
          emit(AuthLoaded());
        }
        else {
          emit(AuthWrongDataError());
        }
      }
    });
  }
}
