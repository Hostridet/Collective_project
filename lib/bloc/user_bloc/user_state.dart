part of 'user_bloc.dart';

@immutable
abstract class UserState {}

class UserInitial extends UserState {}

class UserLoadedState extends UserState {
  String name;
  String surname;
  String patronymic;

  UserLoadedState(this.name, this.surname, this.patronymic);
}
