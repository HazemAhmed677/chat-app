// ignore: depend_on_referenced_packages
import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial());

  Future<void> userLogin(
      {required String email, required String password}) async {
    emit(LoginLoading());
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
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
  }
}
