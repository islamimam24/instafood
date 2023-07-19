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
import 'package:instafood/widgets/user_date_icon.dart';
import '../data/repository/auth_repo.dart';
import 'cart_controller.dart';

class StandardAuth extends GetxController implements IStandardAuth {
  AuthRepo authRepo;
  UsersData usersDataIns;
  StandardAuth({required this.authRepo, required this.usersDataIns});

  bool isON = true;
  bool isSignedUp = false;
  bool isPhoneExist = false;
  get getUserLoginPhoneNo {
    String? phone = authRepo.getPhoneNo();
    int? phoneNo = int.tryParse(phone!);
    return phoneNo;
  }

  get usersData => usersDataIns.usersData;

  UserModel tempUserModel = UserModel();
  UserModel currentUserModel = UserModel();

  @override
  setTempUserModelForSignUn({emailController, passwordController, phoneController, nameController}) {
    if (emailController == null ||
        passwordController == null ||
        phoneController == null ||
        nameController == null) {
      errorSnackBar("* All Sections is required to fill");
    } else {
      tempUserModel.email = emailController.toString();
      tempUserModel.password = passwordController.toString();
      tempUserModel.phone = int.tryParse(phoneController.toString());
      tempUserModel.name = nameController.toString();
      // print(tempUserModel.toJson());
    }
  }

  formValidation(UserModel userModel) {
    isSignedUp = false;
    // int phoneNum = int.parse(phoneController.text);
    // phoneExist(phoneNum);
    while (isON) {
      if (userModel.email.toString().isEmpty ||
          userModel.password.toString().isEmpty ||
          userModel.phone.toString().isEmpty ||
          userModel.name.toString().isEmpty) {
        errorSnackBar("* All Sections is required to fill");
        break;
      }

      /// Email Validation
      else if (!GetUtils.isEmail(userModel.email.toString())) {
        errorSnackBar("this is not a valid Email");
        break;
      }

      /// Password Validation
      else if (userModel.password.toString().length <= 7) {
        errorSnackBar("Password must be more than 7 letters");
        break;
      } else if (!RegExp(r'^(?=.*?[A-Z]).{8,}$').hasMatch(userModel.password.toString())) {
        errorSnackBar("Password Must include an uppercase letter.");
        break;
      } else if (!RegExp(r'^(?=.*?[0-9]).{8,}$').hasMatch(userModel.password.toString())) {
        errorSnackBar("Password Must include a number");
        break;
      } else if (!RegExp(r'^(?=.*?[!@#&*~]).{8,}$').hasMatch(userModel.password.toString())) {
        errorSnackBar("use at least on of !@#\$&*~");
        break;
      }

      /// Name Validation
      else if (userModel.name.toString().length <= 3) {
        errorSnackBar("name must be more than 3 letters");
        break;
      }

      /// phone Validation
      else if (userModel.phone.toString().length != 11) {
        errorSnackBar("phone number must be 11 digits");
        break;
      } else if (isPhoneExist == true) {
        errorSnackBar("this phone No. already exists");
        break;
      } else {
        isON = false;
        isSignedUp = true;
      }
    }
    if (isON == false && isSignedUp == true) {
      currentUserModel = tempUserModel;
      tempUserModel = UserModel();
      // currentUserModel.email = emailController.text;
      // currentUserModel.password = passwordController.text;
      // currentUserModel.name = nameController.text;
      // currentUserModel.phone = int.parse(phoneController.text);

      // emailController.text = "";
      // passwordController.text = "";
      // nameController.text = "";
      // phoneController.text = "";
    }
  }

  // addUserInfo(UserModel userModel) {}

  @override
  void signUp() {
    if (tempUserModel.email != null) {
      formValidation(tempUserModel);
    }
    if (currentUserModel.email != null) {
      if (usersData.containsKey(currentUserModel.email)) {
        errorSnackBar("this email already signed up try to Sign in");
      } else {
        if (currentUserModel.email != null) {
          usersDataIns.setUserData(userModel: currentUserModel, isGoogleUser: false);
          // isSignedUp = true;
          usersDataIns.setCurrentUserModel = currentUserModel;
          Get.toNamed(AppRoutes.getHome());
        }
      }
    }
    update();
  }

  @override
  setTempUserModelForSignin({phoneController, passwordController}) {
    tempUserModel.phone = int.tryParse(phoneController);
    tempUserModel.password = passwordController;
  }

  @override
  signInValidation(UserModel userModel) {
    if (userModel.phone.toString().isEmpty || userModel.password.toString().isEmpty) {
      errorSnackBar("Fields are Required*");
    } else if (userModel.phone.runtimeType != int) {
      errorSnackBar("invalid phone No.");
    } else {
      var phoneNum = int.parse(userModel.phone.toString());
      int index = 0;
      for (var element in usersData.values) {
        index += 1;

        if (phoneNum == element["phone"] && userModel.password == element["password"]) {
          currentUserModel = element.runtimeType == UserModel ? element : UserModel.fromJson(element);
          break;
        } else if (index == usersData.values.length) {
          errorSnackBar("Not Authorized");
          break;
        } else if (phoneNum.isNaN) {
          errorSnackBar("Invalid phone number");
          break;
        }
      }
    }
  }

  @override
  signIn() {
    if (tempUserModel.phone != null) {
      signInValidation(tempUserModel);
    }
    if (currentUserModel.email != null) {
      usersDataIns.setCurrentUserModel = currentUserModel;
      Get.toNamed(AppRoutes.getHome());
    }
    update();
  }

  @override
  signOut() {
    usersDataIns.setCurrentUserModel = UserModel();
    authRepo.removeSavedLoginInfo();
    Get.toNamed(AppRoutes.signInPage);
    update();
  }
}
