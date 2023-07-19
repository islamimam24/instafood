import 'package:flutter/material.dart';
import 'package:instafood/widgets/small_text.dart';
import 'package:get/get.dart';
import '../utils/colors.dart';
import '../utils/dimensions.dart';

class AppTextField extends StatefulWidget {
  String inputTitle;
  IconData icon;
  Color iconColor;
  TextEditingController textEditingController;
  bool isObscure;

  AppTextField(
      {Key? key,
      required this.inputTitle,
      required this.icon,
      required this.textEditingController,
      this.iconColor = AppColors.mainColor,
      this.isObscure = false})
      : super(key: key);

  @override
  State<AppTextField> createState() => _AppTextFieldState();
}

class _AppTextFieldState extends State<AppTextField> {
  bool tapped = false;

  @override
  Widget build(BuildContext context) {
    bool tapped = false;

    return Container(
      margin: EdgeInsets.only(
          left: Dimensions.dim15, right: Dimensions.dim15, bottom: Dimensions.dim30),
      decoration: BoxDecoration(
          color: AppColors.textFieldColor,
          borderRadius: BorderRadius.circular(Dimensions.dim10),
          boxShadow: [
            BoxShadow(
                blurRadius: Dimensions.dim10,
                spreadRadius: Dimensions.dim5,
                offset: Offset(1, Dimensions.dim10),
                color: Colors.grey.withOpacity(.2))
          ]),
      child: Column(
        children: [
          TextField(
              onTap: () {
                tapped = !tapped;
              },
              cursorColor: AppColors.buttonColorBlack,
              controller: widget.textEditingController,
              obscureText: widget.isObscure,
              decoration: InputDecoration(
                hintText: widget.inputTitle,
                // label: Text(widget.inputTitle),
                // labelStyle: const TextStyle(
                //   color: AppColors.buttonColor,
                //   letterSpacing: 1,
                // ),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(Dimensions.dim30))),
                prefixIcon: Icon(widget.icon, color: widget.iconColor),
                enabledBorder: OutlineInputBorder(borderSide: BorderSide.none),
                focusedBorder: OutlineInputBorder(borderSide: BorderSide.none),
              )),
          tapped ? SmallText(title: "use !@#\$&*~") : SizedBox.shrink(),
        ],
      ),
    );
  }
}
