import 'package:flutter/material.dart';
import 'package:instafood/widgets/big_text.dart';
import '../utils/colors.dart';
import '../utils/dimensions.dart';

class UserDataCard extends StatelessWidget {
  String title;
  Color? bgColor, textColor;
  UserDataCard({
    Key? key,
    required this.title,
    this.bgColor = AppColors.textFieldColor,
    this.textColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: 300,
      margin: EdgeInsets.only(
          left: Dimensions.dim15, right: Dimensions.dim15, bottom: Dimensions.dim30),
      decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(Dimensions.dim10),
          boxShadow: [
            BoxShadow(
                blurRadius: Dimensions.dim10,
                spreadRadius: Dimensions.dim5,
                offset: Offset(1, Dimensions.dim10),
                color: Colors.grey.withOpacity(.2))
          ]),
      child: Center(
        child: BigText(
          title: title,
          color: textColor,
        ),
      ),
    );
  }
}
