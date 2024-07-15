part of 'auth_bloc.dart';

@immutable
sealed class AuthEvent {}

final class LoginEvent extends AuthEvent {}

final class RegisterEvent extends AuthEvent {}
