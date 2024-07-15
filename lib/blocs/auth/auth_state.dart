part of 'auth_bloc.dart';

@immutable
sealed class AuthState {}

final class AuthInitial extends AuthState {}

final class LoginLoading extends AuthState {}

final class LoginSuccess extends AuthState {}

final class LoginFaliure extends AuthState {
  final String errorMsg;
  LoginFaliure({required this.errorMsg});
}

final class RegisterLoading extends AuthState {}

final class RegisterSuccess extends AuthState {}

final class RegisterFaliure extends AuthState {
  final String errorMsg;
  RegisterFaliure({required this.errorMsg});
}
