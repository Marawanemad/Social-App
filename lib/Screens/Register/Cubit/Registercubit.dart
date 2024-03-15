import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socialapp/Modeles/SocialUserModel.dart';
import 'package:socialapp/Screens/Register/Cubit/RegisterStates.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SocialRegisterCubit extends Cubit<SocialRegisterState> {
// to make intialize super cubit
  SocialRegisterCubit() : super(SocialRegisterIntialState());
// to make object from cubit use it in any place
  static SocialRegisterCubit get(context) => BlocProvider.of(context);

// to make register function take data from regester screen and make signup in firebase
  void userRegister(
      {required String email,
      required String password,
      required String name,
      required String phone}) {
    // to make load when check data
    emit(SocialRegisterLoadingState());
    // to make sign up in firebase by email and password
    FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password)
        .then((value) {
      print(value.user!.email);
      print(value.user!.uid);
      userCreate(email: email, name: name, phone: phone, uID: value.user!.uid);
    }).catchError((error) {
      print(error.toString());
      emit(SocialRegisterErrorState(error.toString()));
    });
  }

  void userCreate({
    required String email,
    required String name,
    required String phone,
    required String uID,
  }) {
    // call model to get data from map
    SocilUserModel model = SocilUserModel(
      email: email,
      name: name,
      phone: phone,
      uID: uID,
      bio: 'Write your bio ...',
      Image:
          "https://img.freepik.com/free-photo/medium-shot-man-wearing-vr-glasses_23-2149126949.jpg?w=1060&t=st=1708530873~exp=1708531473~hmac=51ff3d9b20d5094538d03b4b7aaa9ebdcaf96ab68d0681d3e665f17981283db5",
      Cover:
          "https://img.freepik.com/free-photo/revenue-operations-collage_23-2150847854.jpg?w=996&t=st=1708530865~exp=1708531465~hmac=898ea58b87723a033e6cea856feec7cc4289e0a95351d6a10ffff259073ec53e",
    );
    // to store data in firebase make collection and inside it doc and inside it data
    FirebaseFirestore.instance
        .collection("Users")
        .doc(uID)
        .set(model.toMap())
        .then((value) {
      emit(SocialCreateSuccessState());
    }).catchError((error) {
      emit(SocialCreateErrorState(error));
    });
  }

  IconData suffixIcon = Icons.visibility_off_rounded;
  bool isPasswordobscure = true;
  void ChangeSuffixIcon() {
    isPasswordobscure = !isPasswordobscure;
    isPasswordobscure == true
        ? suffixIcon = Icons.visibility_off_rounded
        : suffixIcon = Icons.visibility_outlined;
    emit(ChangeRegisterSuffixIconState());
  }
}
