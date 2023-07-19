import 'package:get/get.dart';
import 'package:instafood/controllers/auth_interface.dart';

import '../data/repository/auth_repo.dart';
import '../models/user_model.dart';

class UsersData {
  AuthRepo authRepo;
  UsersData({required this.authRepo});
  Map<String, dynamic> usersData = {};
  UserModel? _currentUserModel;
  UserModel? savedUserModel;

  set setCurrentUserModel(value) {
    UserModel? currentUSer;
    if (value.runtimeType == UserModel) {
      currentUSer = value;
    } else if (value.runtimeType == Map<String, dynamic>) {
      currentUSer = UserModel.fromJson(value);
    }
    authRepo.saveUserLogInfo(
        email: currentUSer?.email.toString(),
        password: currentUSer?.password.toString(),
        phone: currentUSer?.phone.toString());
    _currentUserModel = currentUSer;
  }

  UserModel? get getCurrentUserModel => _currentUserModel;
  get getUserLoginPassword => authRepo.getPassword();
  get getUserLoginEmail => authRepo.getEmail();

  UserModel? get getCurrentUserModell {
    UserModel userModel = UserModel();
    usersData.forEach((key, value) {
      if (key == getUserLoginEmail.toString()) {
        if (usersData[key].runtimeType == UserModel) {
          userModel = usersData[key];
        } else {
          userModel = UserModel.fromJson(usersData[key]);
        }
      }
    });
    // update();
    return userModel;
  }

  getUsersData() async {
    usersData = {};
    Response response = await authRepo.getUsersData();
    if (response.statusCode == 200) {
      Map<String, dynamic> data = response.body;
      usersData.addAll(data);
      return usersData;
    }
  }

  // setCurrentUserModelFunc(value) {
  //   UserModel? currentUSer;
  //   if (value.runtimeType == UserModel) {
  //     currentUSer = value;
  //   } else if (value.runtimeType == Map<String, dynamic>) {
  //     currentUSer = UserModel.fromJson(value);
  //   }
  //   authRepo.saveUserLogInfo(
  //       email: currentUSer?.email.toString(),
  //       password: currentUSer?.password.toString(),
  //       phone: currentUSer?.phone.toString());
  //   _currentUserModel = currentUSer;
  //   // update();
  //   return currentUSer;
  // }

  getSavdUserDataModel() {
    usersData.forEach((key, value) {
      if (key == getUserLoginEmail.toString()) {
        // if (value.runtimeType == dynamic) {
        savedUserModel = UserModel.fromJson(usersData[key]);
      }
    });
  }

  setUserData({required UserModel userModel, required bool isGoogleUser}) {
    final Map<String, UserModel> userData = {};
    isGoogleUser
        ? usersData.putIfAbsent(userModel.email!.toString(), () {
            return UserModel(
                email: userModel.email,
                password: userModel.password,
                name: userModel.name,
                // phone: userModel.phone,
                photoURL: userModel.photoURL,
                isGoogleUser: true,
                cartModelList: userModel.cartModelList,
                favProductList: userModel.favProductList);
          })
        : usersData.putIfAbsent(userModel.email!.toString(), () {
            return UserModel(
                email: userModel.email,
                password: userModel.password,
                name: userModel.name,
                phone: userModel.phone,
                isGoogleUser: false,
                cartModelList: userModel.cartModelList,
                favProductList: userModel.favProductList);
          });
    userData.assign(userModel.email!.toString(), userModel);
    authRepo.setUserData(userData);
    // update();
  }

  /// only works if  you have full userModel on cloud but you need to update specific property
  updateUserData({property, setValue}) {
    // print(usersData[getUserLoginEmail]);
    Map<String, dynamic> newUserData = {};

    if (usersData.containsKey(getCurrentUserModel?.email)) {
      usersData.forEach((key, value) {
        if (key == getCurrentUserModel?.email) {
          Map<String, dynamic> currentUserData =
              usersData[key].runtimeType == UserModel ? usersData[key].toJson() : usersData[key];
          currentUserData[property] = setValue;
          usersData[getCurrentUserModel!.email.toString()] = UserModel.fromJson(currentUserData);

          newUserData.assign(
              getCurrentUserModel!.email.toString(), usersData[getCurrentUserModel!.email.toString()]);
          authRepo.setUserData(newUserData);
        }
      });
      usersData.update(getCurrentUserModel!.email.toString(),
          (value) => newUserData[getCurrentUserModel!.email.toString()]);
    }
    // update();
    return newUserData;
  }
  // Map<String, dynamic> toJson(){
  //   Map<String, dynamic>
  // }
}
