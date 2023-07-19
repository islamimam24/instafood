import 'package:flutter/material.dart';
import 'package:instafood/utils/colors.dart';
import 'package:instafood/utils/dimensions.dart';
import 'package:instafood/widgets/big_text.dart';

class userDataIcon extends StatelessWidget {
  IconData icon;
  String title;
  double? size;
  Color? bgIconColor;
  Color? iconColorInside;

  userDataIcon({
    Key? key,
    required this.icon,
    required this.title,
    this.size,
    this.bgIconColor = AppColors.iconColorBlack,
    this.iconColorInside = AppColors.iconColorWhite,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: Dimensions.dim60,
      width: double.maxFinite,

      margin: EdgeInsets.only(bottom: Dimensions.dim10),
      // color: Colors.red,
      child: Row(
        children: [
          SizedBox(width: Dimensions.dim10),
          Container(
            width: Dimensions.dim50,
            height: Dimensions.dim50,
            decoration: BoxDecoration(color: bgIconColor, shape: BoxShape.circle),
            child: Icon(
              icon,
              size: size ?? Dimensions.dim30,
              color: iconColorInside,
            ),
          ),
          SizedBox(width: Dimensions.dim20),
          BigText(title: title)
        ],
      ),
    );
  }
}
