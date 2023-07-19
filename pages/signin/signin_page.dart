import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:instafood/controllers/auth_controller.dart';
import 'package:instafood/controllers/google_auth.dart';
import 'package:instafood/routes/routes.dart';
import 'package:instafood/utils/colors.dart';
import 'package:instafood/utils/dimensions.dart';
import 'package:instafood/widgets/app_text_field.dart';
import 'package:instafood/widgets/big_text.dart';
import 'package:get/get.dart';
import 'package:instafood/widgets/small_text.dart';

import '../../controllers/standard_auth.dart';
import '../signup/signup_page.dart';

class SignInPage extends StatelessWidget {
  SignInPage({Key? key}) : super(key: key);
  List signupImages = ["f.png", "g.png"];

  @override
  Widget build(BuildContext context) {
    TextEditingController passwordController = TextEditingController();
    TextEditingController phoneController = TextEditingController();
    // GoogleAuthController googleAuthController = Get.find<GoogleAuthController>();
    return GetBuilder<AuthController>(
      builder: (authController) {
        return Scaffold(
          backgroundColor: AppColors.appBasicColor,
          body: SafeArea(
              child: SingleChildScrollView(
            // padding: BouncingScrollPhysics(),
            child: Column(
              children: [
                Center(child: Image.asset("assets/images/instafood_logo.png", height: Dimensions.dim220)),
                Container(
                  height: Dimensions.dim100,
                  width: double.maxFinite,
                  margin: EdgeInsets.only(left: Dimensions.dim20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Hello",
                          style: TextStyle(
                              fontSize: Dimensions.dim40,
                              color: AppColors.mainColor,
                              fontWeight: FontWeight.bold)),
                      BigText(
                        title: "Sign in into your account",
                        color: Colors.grey.shade700,
                        fontSize: Dimensions.dim15,
                      ),
                    ],
                  ),
                ),
                AppTextField(
                  inputTitle: "Phone",
                  icon: Icons.phone,
                  textEditingController: phoneController,
                ),
                AppTextField(
                  inputTitle: "Password",
                  icon: Icons.password,
                  textEditingController: passwordController,
                  isObscure: true,
                ),
                GestureDetector(
                  onTap: () {
                    authController.setUserModelToCheck(Get.find<StandardAuth>(),
                        phoneController: phoneController.text, passwordController: passwordController.text);
                    authController.signIn(Get.find<StandardAuth>());
                  },
                  child: Container(
                    height: Dimensions.dim60,
                    width: Dimensions.dim200,
                    decoration: BoxDecoration(
                        color: AppColors.buttonColorBlack,
                        borderRadius: BorderRadius.circular(Dimensions.dim10)),
                    child: Center(
                      child: BigText(
                        title: "Sign In",
                        color: AppColors.buttonText,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: Dimensions.dim30),
                SmallText(title: "Or"),
                SizedBox(height: Dimensions.dim10),
                GestureDetector(
                  onTap: () {
                    authController.signIn(Get.find<GoogleAuth>());
                  },
                  child: Container(
                    height: Dimensions.dim50,
                    width: Dimensions.dim220,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.blueAccent),
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      color: Colors.white,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircleAvatar(
                            radius: Dimensions.dim20,
                            backgroundColor: Colors.white,
                            backgroundImage: AssetImage('assets/images/g.png')),
                        SizedBox(width: Dimensions.dim10),
                        BigText(
                          title: "Sign in with Google",
                          color: Colors.blueAccent,
                          fontSize: Dimensions.dim15,
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: Dimensions.dim40),
                RichText(
                  text: TextSpan(
                      text: "Not a Member? ",
                      style: TextStyle(color: Colors.grey.shade700, fontSize: Dimensions.dim15),
                      children: [
                        TextSpan(
                            recognizer: TapGestureRecognizer()..onTap = () => Get.to(() => SignUpPage()),
                            text: "Register Now",
                            style: TextStyle(color: AppColors.mainColor, fontWeight: FontWeight.bold))
                      ]),
                )
              ],
            ),
          )),
        );
      },
    );
  }
}
