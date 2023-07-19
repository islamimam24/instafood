import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:instafood/controllers/auth_controller.dart';
import 'package:instafood/controllers/google_auth.dart';
import 'package:instafood/controllers/standard_auth.dart';
import 'package:instafood/controllers/users_data.dart';
import 'package:instafood/models/user_model.dart';
import 'package:instafood/utils/colors.dart';
import 'package:instafood/utils/dimensions.dart';
import 'package:instafood/widgets/app_text_field.dart';
import 'package:instafood/widgets/user_data_card.dart';
import 'package:instafood/widgets/bottom_sheet.dart';
import 'package:instafood/widgets/user_date_icon.dart';
import 'package:instafood/widgets/big_text.dart';
import 'package:instafood/widgets/must_sign_in_page.dart';
import 'package:get/get.dart';

import '../../widgets/snackbar.dart';
// import 'package:intl_phone_number_input/intl_phone_number_input.dart';

class ProfilePage extends StatefulWidget {
  ProfilePage({Key? key}) : super(key: key);
  late String phoneNo;
  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  UserModel currentUser = UserModel();
  getCurrentUSer() {
    if (Get.find<UsersData>().getCurrentUserModel != null) {
      currentUser = Get.find<UsersData>().getCurrentUserModell!;
    }
  }

  @override
  void initState() {
    getCurrentUSer();
    super.initState();
    // setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    int? phoneNo;

    return GetBuilder<AuthController>(
      builder: (authController) {
        // var currentUser = authController.getCurrentUserModel;
        // var googleCurrentUser = ;
        return currentUser.email == null
            ? const MustSignIn()
            : Scaffold(
                body: SafeArea(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        SizedBox(height: Dimensions.dim30),
                        Center(
                            child: Container(
                          height: Dimensions.dim150,
                          width: Dimensions.dim150,
                          decoration:
                              const BoxDecoration(shape: BoxShape.circle, color: AppColors.iconColorBlack),
                          child: currentUser.photoURL == null
                              ? const Icon(Icons.person, size: 80, color: AppColors.iconColorYellow)
                              : CircleAvatar(
                                  backgroundImage: NetworkImage(currentUser.photoURL.toString()),
                                ),
                        )),
                        SizedBox(height: Dimensions.dim50),
                        UserDataCard(title: currentUser.name.toString()),
                        GestureDetector(
                          onTap: () {
                            _showAlertDialog(context, onPressedFun: () {
                              if (phoneNo.toString().length != 10) {
                                errorSnackBar("Phone No must be 11 digits");
                              } else {
                                // authController.addPhoneNoToCloud(phoneNo!);
                                getCurrentUSer();
                                Navigator.pop(context);
                                // currentUser.phone = phoneNo;
                              }
                            }, onChanged: (value) {
                              phoneNo = int.tryParse(value);
                            });
                            setState(() {});
                          },
                          child: UserDataCard(
                            title: currentUser.phone == null
                                ? "add your phone No."
                                : "0${currentUser.phone.toString()}",
                            bgColor: AppColors.appBasicColor,
                            textColor: AppColors.textFieldColor,
                          ),
                        ),
                        // : UserDataCard(title: "0${currentUser.phone.toString()}"),

                        UserDataCard(title: currentUser.email.toString()),
                        UserDataCard(
                          title: "Fill in your location",
                          bgColor: AppColors.appBasicColor,
                          textColor: AppColors.textFieldColor,
                        ),
                        GestureDetector(
                            onTap: () {
                              authController.signOut(Get.find<GoogleAuth>());
                              authController.signOut(Get.find<StandardAuth>());
                            },
                            child: UserDataCard(
                              title: "Logout",
                              bgColor: AppColors.mainColor,
                              textColor: AppColors.textFieldColor,
                            )),
                      ],
                    ),
                  ),
                ),
              );
      },
    );
  }

  void _showAlertDialog(BuildContext context, {onPressedFun, onChanged}) {
    TextEditingController phone = TextEditingController();
    widget.phoneNo = phone.text;
    try {
      showCupertinoModalPopup<void>(
        context: context,
        builder: (BuildContext context) => CupertinoAlertDialog(
          title: const Text('Add your Phone No.'),
          content: SingleChildScrollView(
            child: Card(
              color: Colors.transparent,
              elevation: 0.0,
              child: Column(
                children: [
                  SizedBox(
                    width: Dimensions.dim300,
                    height: Dimensions.dim40,
                    child:
                        TextField(keyboardType: TextInputType.phone, controller: phone, onChanged: onChanged),
                  ),
                ],
              ),
            ),
          ),
          actions: <CupertinoDialogAction>[
            CupertinoDialogAction(
              /// This parameter indicates this action is the default,
              /// and turns the action's text to bold text.
              isDefaultAction: true,
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Cancel'),
            ),
            CupertinoDialogAction(
              /// This parameter indicates the action would perform
              /// a destructive action such as deletion, and turns
              /// the action's text color to red.
              isDestructiveAction: true,
              onPressed: onPressedFun,
              child: const Text('Add'),
            ),
          ],
        ),
      );
    } catch (e, s) {
      print(s);
    }
  }
}
