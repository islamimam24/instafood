import 'package:flutter/material.dart';

import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter/widgets.dart';
import 'package:instafood/utils/colors.dart';
import 'package:instafood/utils/dimensions.dart';

class AppIcon extends StatelessWidget {
  final IconData icon;
  Color? bgColor;
  Color? iconColor;
  double? iconSize;

  AppIcon({super.key, required this.icon, this.bgColor, this.iconColor, this.iconSize = 20});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: Dimensions.dim50,
      width: Dimensions.dim50,

      // ignore: prefer_const_constructors
      decoration: BoxDecoration(
        color: bgColor ?? AppColors.iconColorBlack,
        shape: BoxShape.circle,
      ),
      child: Icon(
        icon,
        color: iconColor ?? AppColors.iconColorWhite,
        size: iconSize,
      ),
    );
  }
}
