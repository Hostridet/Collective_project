part of 'auth_bloc.dart';

@immutable
abstract class AuthState {}

class AuthInitial extends AuthState {}

class AuthLoading  extends AuthState {}

class AuthLoaded extends AuthState {}

class AuthEmptyError extends AuthState {}

class AuthWrongDataError extends AuthState {}