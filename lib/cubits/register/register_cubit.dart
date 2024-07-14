// ignore: depend_on_referenced_packages
import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';

part 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit() : super(RegisterInitial());

  Future<void> userRegister(
      {required String email, required String password}) async {
    try {
      emit(RegisterLoading());
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
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
}
