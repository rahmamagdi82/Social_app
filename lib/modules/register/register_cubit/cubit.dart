import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/models/users_model.dart';

import 'states.dart';


class RegisterCubit extends Cubit<RegisterStates>{
  RegisterCubit() : super(RegisterInitialState());
  static RegisterCubit get(context)=>BlocProvider.of(context);

  bool obsecure=true;
  IconData icon=Icons.visibility;
void changeShowPassword()
{
  obsecure=!obsecure;
  obsecure? (icon=Icons.visibility): (icon=Icons.visibility_off);
  emit(RegisterChangePasswordState());
}


void createUser({
  required String name,
  required String email,
  required String uId,
  required String? phone,
}){
Users model=Users(
    name: name,
    email: email,
    phone: phone,
    uId: uId,
  isEmailVerified: false,
  image: 'https://t4.ftcdn.net/jpg/02/18/22/33/240_F_218223302_dD8ur4d3HNSX4KaQB0KhzyILk3CSsE7M.jpg',
  cover: 'https://img.freepik.com/free-photo/beautiful-scenery-pathway-forest-with-trees-covered-with-frost_181624-42376.jpg?t=st=1657003515~exp=1657004115~hmac=2e2c707cdf8c536d1f815263bfa29ed240e0f30e63dc4cf38ff340dc0daf90fe&w=996',
  bio: 'write your bio...',

);
  FirebaseFirestore.instance.collection('users').doc(uId).set(model.toMap()).then((value)
  {
    emit(RegisterCreateUserSuccessState(model.uId.toString()));
  }).catchError((error)
  {
    print(error.toString());
    emit(RegisterCreateUserErrorState());
  });
}

void userRegister({
    required String name,
    required String email,
    required String password,
    required String phone

  }){
    FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
    ).then((value)
    {
      createUser(name: name, email: email, uId: value.user!.uid, phone: phone);
    }).catchError((error)
    {
      print(error.toString());
      emit(RegisterErrorState());
    });
  }

}