// ignore: depend_on_referenced_packages
import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:meta/meta.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthInitial()) {
    on<AuthEvent>(
      (event, emit) async {
        if (event is LoginEvent) {
          emit(LoginLoading());
          try {
            await FirebaseAuth.instance.signInWithEmailAndPassword(
              email: event.email,
              password: event.password,
            );
            emit(LoginSuccess());
          } on FirebaseAuthException catch (e) {
            if (e.toString().contains('weak-password')) {
              emit(LoginFaliure(errorMsg: 'weak password'));
            } else if (e.toString().contains('in use')) {
              emit(LoginFaliure(errorMsg: 'email already exists'));
            } else if (e.toString().contains('badly formatted')) {
              emit(LoginFaliure(errorMsg: 'email is invalid'));
            } else {
              emit(LoginFaliure(errorMsg: 'password is incorrect'));
            }
          } catch (e) {
            emit(LoginFaliure(errorMsg: 'somthing went wrong'));
          }
        } else if (event is RegisterEvent) {
          try {
            emit(RegisterLoading());
            await FirebaseAuth.instance.createUserWithEmailAndPassword(
              email: event.email,
              password: event.password,
            );
            emit(RegisterSuccess());
          } on FirebaseAuthException catch (e) {
            if (e.toString().contains('weak-password')) {
              emit(RegisterFaliure(errorMsg: 'weak password'));
            } else if (e.toString().contains('in use')) {
              emit(RegisterFaliure(errorMsg: 'email already exists'));
            } else if (e.toString().contains('badly formatted')) {
              emit(RegisterFaliure(errorMsg: 'email is invalid'));
            }
          } catch (e) {
            emit(RegisterFaliure(errorMsg: 'somthing went wrong'));
          }
        }
      },
    );
  }
}
