import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:instafood/controllers/auth_interface.dart';
import 'package:instafood/controllers/users_data.dart';
import 'package:instafood/models/cart_model.dart';
import 'package:instafood/models/products_model.dart';
import 'package:instafood/models/user_model.dart';
import 'package:instafood/routes/routes.dart';
import 'package:instafood/widgets/snackbar.dart';
import 'package:get/get.dart';
import '../data/repository/auth_repo.dart';
import 'cart_controller.dart';

class AuthController extends GetxController {
  // IAuth? iAuth;
  // IStandardAuth? _iStandardAuth;

  setTempUserModelForSignUn(IStandardAuth iStandardAuth,
      {emailController, passwordController, phoneController, nameController}) {
    iStandardAuth.setTempUserModelForSignUn(
      emailController: emailController,
      passwordController: passwordController,
      nameController: nameController,
      phoneController: phoneController,
    );
  }

  setUserModelToCheck(IStandardAuth iStandardAuth, {phoneController, passwordController}) {
    iStandardAuth.setTempUserModelForSignin(
        phoneController: phoneController, passwordController: passwordController);
  }

  signUp(IStandardAuth iStandardAuth) {
    iStandardAuth.signUp();
  }

  signIn(IAuth iAuth) {
    iAuth.signIn();
  }

  signOut(IAuth iAuth) {
    iAuth.signOut();
  }

  signInValidation(IAuth iAuth, UserModel userModel) {
    iAuth.signInValidation(userModel);
  }

  // void phoneExist(int phone) {
  //   for (var e in usersData.values) {
  //     if (e["phone"] == phone) {
  //       isPhoneExist = true;
  //     }
  //   }
  // }
}
