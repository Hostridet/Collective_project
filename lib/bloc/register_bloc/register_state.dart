part of 'register_bloc.dart';

@immutable
abstract class RegisterState {}

class RegisterInitial extends RegisterState {}

class RegisterLoadingState extends RegisterState {}

class RegisterEmailError extends RegisterState {}

class RegisterLoadedState extends RegisterState {}

class RegisterEmptyError extends RegisterState {}

class RegisterBusyError extends RegisterState {}

