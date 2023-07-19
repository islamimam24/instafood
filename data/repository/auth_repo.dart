import 'dart:collection';

import 'package:instafood/data/api/api_client.dart';
import 'package:instafood/models/user_model.dart';
import 'package:instafood/utils/app_constant.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthRepo {
  APIClient apiClient;

  SharedPreferences sharedPreferences;

  AuthRepo({required this.apiClient, required this.sharedPreferences});

  void setUserData(Map<String, dynamic> map) async {
    try {
      // await apiClient.setUserData("${AppConstant.REST_USERS}/${userModel.email}", map);
      await apiClient.setData(AppConstant.REST_USERS, map);
    } on Exception catch (e) {
      print("auth Error: $e");
    }
  }

  // void updateUser() async {
  //   await apiClient.updateData("${AppConstant.REST_USERS}/");
  // }

  Future<Response> getUsersData() async {
    return await apiClient.getData(AppConstant.REST_USERS);
  }

  void saveUserLogInfo({email, password, phone}) {
    sharedPreferences.setString(AppConstant.userLoginEmail, email);
    sharedPreferences.setString(AppConstant.userLoginPassword, password);
    if (phone != null) {
      sharedPreferences.setString(AppConstant.userLoginPhone, phone);
    }
  }

  String? getPhoneNo() {
    String phoneNo = "";
    if (sharedPreferences.containsKey(AppConstant.userLoginPhone)) {
      phoneNo = sharedPreferences.get(AppConstant.userLoginPhone).toString();
    }
    return phoneNo;
  }

  String? getPassword() {
    String password = "";
    if (sharedPreferences.containsKey(AppConstant.userLoginPassword)) {
      password = sharedPreferences.get(AppConstant.userLoginPassword).toString();
    }
    return password;
  }

  String? getEmail() {
    String email = "";
    if (sharedPreferences.containsKey(AppConstant.userLoginEmail)) {
      email = sharedPreferences.get(AppConstant.userLoginEmail).toString();
    }
    return email;
  }

  void removeSavedLoginInfo() {
    sharedPreferences.remove(AppConstant.userLoginPhone);
    sharedPreferences.remove(AppConstant.userLoginPassword);
    sharedPreferences.remove(AppConstant.userLoginEmail);
  }
}
