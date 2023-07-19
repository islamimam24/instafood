import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:instafood/controllers/auth_controller.dart';
import 'package:instafood/controllers/standard_auth.dart';
import 'package:instafood/pages/home/home.dart';
import 'package:instafood/pages/signin/signin_page.dart';
import 'package:instafood/utils/colors.dart';
import 'package:instafood/utils/dimensions.dart';
import 'package:instafood/widgets/app_text_field.dart';
import 'package:instafood/widgets/big_text.dart';
import 'package:instafood/widgets/snackbar.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../controllers/cart_controller.dart';
import '../../routes/routes.dart';

class SignUpPage extends StatelessWidget {
  String finalEmail = "", finalName = "", finalPassword = "";
  int? finalPhone = 0;
  bool signedUp = false;

  SignUpPage({Key? key}) : super(key: key);

  // List signupImages = ["f.png", "g.png"];

  @override
  Widget build(BuildContext context) {
    TextEditingController emailController = TextEditingController();
    TextEditingController nameController = TextEditingController();
    TextEditingController passwordController = TextEditingController();
    TextEditingController phoneController = TextEditingController();

    return GetBuilder<AuthController>(builder: (authController) {
      // authController.getUsersData();
      return Scaffold(
          backgroundColor: AppColors.appBasicColor,
          body: SafeArea(
              child: SingleChildScrollView(
            // padding: BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () {
                    Get.toNamed(AppRoutes.getHome());
                  },
                  child: Center(
                      child: Image.asset("assets/images/instafood_logo.png", height: Dimensions.dim200)),
                ),
                AppTextField(
                  inputTitle: "Email",
                  icon: Icons.mail,
                  textEditingController: emailController,
                ),
                GestureDetector(
                  onTap: () {
                    authController.update();
                  },
                  child: AppTextField(
                    inputTitle: "Password",
                    icon: Icons.password,
                    textEditingController: passwordController,
                    isObscure: true,
                  ),
                ),
                AppTextField(
                  inputTitle: "Name",
                  icon: Icons.person,
                  textEditingController: nameController,
                ),
                AppTextField(
                  inputTitle: "Phone",
                  icon: Icons.phone,
                  textEditingController: phoneController,
                ),
                // signedUp
                //     ? BigText(title: "Success", color: Colors.green.shade700)
                //     : const SizedBox.shrink(),
                GestureDetector(
                  onTap: () {
                    authController.setTempUserModelForSignUn(
                      Get.find<StandardAuth>(),
                      emailController: emailController.text,
                      passwordController: passwordController.text,
                      nameController: nameController.text,
                      phoneController: phoneController.text,
                    );
                    authController.signUp(Get.find<StandardAuth>());

                    /// user feedback
                  },
                  child: Container(
                    height: Dimensions.dim60,
                    width: Dimensions.dim200,
                    decoration: BoxDecoration(
                        color: AppColors.buttonColorBlack,
                        borderRadius: BorderRadius.circular(Dimensions.dim10)),
                    child: Center(
                      child: BigText(
                        title: "Sign Up",
                        color: AppColors.buttonText,
                      ),
                    ),
                  ),
                ),

                SizedBox(height: Dimensions.dim65),

                RichText(
                  text: TextSpan(
                      text: "Have an Account Already? ",
                      style: TextStyle(color: Colors.grey.shade700, fontSize: Dimensions.dim15),
                      children: [
                        TextSpan(
                            recognizer: TapGestureRecognizer()..onTap = () => Get.to(() => SignInPage()),
                            text: "Sign In",
                            style: TextStyle(color: AppColors.mainColor, fontWeight: FontWeight.bold))
                      ]),
                ),
              ],
            ),
          )));
    });
  }
}
