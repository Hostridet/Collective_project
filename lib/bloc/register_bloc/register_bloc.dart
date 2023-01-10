import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../repository/AuthRepository.dart';

part 'register_event.dart';
part 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  final AuthRepository _authRepository;
  RegisterBloc(this._authRepository) : super(RegisterInitial()) {
    on<RegisterAddEvent>((event, emit) async {
      if (event.login.isEmpty || event.password.isEmpty || event.name.isEmpty
          || event.surname.isEmpty || event.patronymic.isEmpty || event.email.isEmpty) {
        emit(RegisterEmptyError());
      }
      else {
        if (!event.email.contains("@") || !event.email.contains(".")) {
          emit(RegisterEmailError());
        }
        else {
          bool flag = await _authRepository.checkLogin(event.login);
          if (flag == true) {
            emit(RegisterBusyError());
          }
          else {
            _authRepository.register(event.login, event.password, event.name,
                event.surname, event.patronymic, event.email);
            emit(RegisterLoadedState());
          }
        }
      }
    });
  }
}
