import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socialapp/Screens/Login/Cubit/LoginStates.dart';

class SocialLoginCubit extends Cubit<SocialLoginState> {
// to make intialize super cubit
  SocialLoginCubit() : super(SocialLoginIntialState());
// to make object from cubit use it in any place
  static SocialLoginCubit get(context) => BlocProvider.of(context);
  void userLogin({
    required String email,
    required String password,
  }) {
    // to make load when check data
    emit(SocialLoginLoadingState());
    // to make sign in to firebase by email and password
    FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password)
        .then((value) {})
        .catchError((error) {
      print(error.toString());
      emit(SocialLoginErrorState(error.toString()));
    });
  }

  IconData suffixIcon = Icons.visibility_off_rounded;
  bool isPasswordobscure = true;
  void ChangeSuffixIcon() {
    isPasswordobscure = !isPasswordobscure;
    isPasswordobscure == true
        ? suffixIcon = Icons.visibility_off_rounded
        : suffixIcon = Icons.visibility_outlined;
    emit(ChangeSuffixIconState());
  }
}
