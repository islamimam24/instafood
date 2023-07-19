import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:instafood/routes/routes.dart';
import 'package:instafood/utils/dimensions.dart';
import 'package:get/get.dart';

import '../utils/colors.dart';

class MustSignIn extends StatelessWidget {
  const MustSignIn({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: RichText(
        text: TextSpan(
            text: "You Must ",
            style: TextStyle(color: Colors.black, fontSize: Dimensions.dim20),
            children: [
              TextSpan(
                  recognizer: TapGestureRecognizer()
                    ..onTap = () => Get.toNamed(AppRoutes.signInPage),
                  text: "Sign In",
                  style: TextStyle(color: AppColors.mainColor, fontWeight: FontWeight.bold)),
              TextSpan(
                  text: " or ", style: TextStyle(color: Colors.black, fontSize: Dimensions.dim20)),
              TextSpan(
                  recognizer: TapGestureRecognizer()
                    ..onTap = () => Get.toNamed(AppRoutes.signUpPage),
                  text: "Sign Up",
                  style: TextStyle(color: AppColors.mainColor, fontWeight: FontWeight.bold)),
            ]),
      ),
    ));
  }
}
