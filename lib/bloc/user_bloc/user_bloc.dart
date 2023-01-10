import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  UserBloc() : super(UserInitial()) {
    on<UserLoadEvent>((event, emit) async  {
      final prefs = await SharedPreferences.getInstance();
      String name = prefs.getString("name")!;
      String surname = prefs.getString("surname")!;
      String patronymic = prefs.getString("patronymic")!;
      emit(UserLoadedState(name, surname, patronymic));
    });
  }
}
