part of 'login_cubit.dart';

sealed class LoginState {}

final class LoginInitial extends LoginState {}

final class LoginLoading extends LoginState {}

final class LoginSuccess extends LoginState {}

final class LoginFaliure extends LoginState {
  final String errorMsg;
  LoginFaliure({required this.errorMsg});
}
