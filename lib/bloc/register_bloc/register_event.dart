part of 'register_bloc.dart';

@immutable
abstract class RegisterEvent {}

class RegisterAddEvent extends RegisterEvent {
  String login;
  String password;
  String name;
  String surname;
  String patronymic;
  String email;

  RegisterAddEvent(this.login, this.password, this.name, this.surname, this.patronymic, this.email);
}
