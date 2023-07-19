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

class GoogleAuth extends GetxController implements IAuth {
  AuthRepo authRepo;
  UsersData usersDataIns;
  GoogleAuth({required this.authRepo, required this.usersDataIns});

  GoogleSignIn currentSignIn = GoogleSignIn();
  get usersData => usersDataIns.usersData;

  @override
  signIn() async {
    UserModel? googleUserModel;
    final GoogleSignInAccount? getUser = await currentSignIn.signIn();

    if (usersData.containsKey(getUser!.email)) {
      UserModel currentUser = usersData[getUser.email].runtimeType == UserModel
          ? usersData[getUser.email]
          : UserModel.fromJson(usersData[getUser.email]);
      usersDataIns.setCurrentUserModel = currentUser;
      authRepo.saveUserLogInfo(
          email: currentUser.email.toString(),
          password: currentUser.password.toString(),
          phone: currentUser.phone.toString());
      signInValidation(currentUser);
    } else {
      googleUserModel = UserModel(
          name: getUser.displayName,
          email: getUser.email,
          photoURL: getUser.photoUrl,
          password: passowordGenerator(),
          isGoogleUser: true);
      usersDataIns.setCurrentUserModel = googleUserModel;
      signInValidation(googleUserModel);
    }
  }

  @override
  signInValidation(UserModel userModel) {
    final Map<String, UserModel> userData = {};

    if (usersData.containsKey(userModel.email)) {
      // _currentUserModel = userModel;
      usersDataIns.setCurrentUserModel = userModel;
      Get.toNamed(AppRoutes.getHome());
    } else {
      usersDataIns.setUserData(userModel: userModel, isGoogleUser: true);
      Get.toNamed(AppRoutes.getHome());
    }
    update();
  }

  updatePhoneNo(int phoneNo) {
    usersDataIns.updateUserData(property: "phone", setValue: phoneNo);
    update();
  }

  passowordGenerator() {
    List pass = [];
    List symbols = ["!", "@", "#", "%", "&", "*", "^", "+", "-"];
    List capital = ["A", "C", "E", "R", "R", "G", "T", "J"];
    List smallLetter = ["q", "w", "u", "o", "k", "x", "z", "y"];

    /// numbers
    Random randomNo = Random();
    pass.add(randomNo.nextInt(100));
    pass.add(randomNo.nextInt(100));
    pass.add(randomNo.nextInt(100));
    pass.add(randomNo.nextInt(100));

    /// sympols
    pass.add(symbols[randomNo.nextInt(symbols.length)]);
    pass.add(symbols[randomNo.nextInt(symbols.length)]);
    pass.add(capital[randomNo.nextInt(capital.length)]);
    pass.add(capital[randomNo.nextInt(capital.length)]);
    pass.add(capital[randomNo.nextInt(capital.length)]);
    pass.add(smallLetter[randomNo.nextInt(smallLetter.length)]);
    pass.add(smallLetter[randomNo.nextInt(smallLetter.length)]);
    List finalList = List.generate(pass.length, (index) => pass[randomNo.nextInt(pass.length)]);
    String finalPass = finalList.join();
    return finalPass;
  }

  @override
  signOut() {
    usersDataIns.setCurrentUserModel = UserModel();
    authRepo.removeSavedLoginInfo();
    currentSignIn.signOut();
    Get.toNamed(AppRoutes.signInPage);
    update();
  }
}
