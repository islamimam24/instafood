import 'package:flutter/material.dart';
import 'package:instafood/utils/colors.dart';
import 'package:instafood/utils/dimensions.dart';
import 'package:instafood/widgets/small_text.dart';

class IconAndTextIcon extends StatelessWidget {
  final IconData iconShape;
  Color? iconColor;
  final String title;
  IconAndTextIcon({super.key, required this.iconShape, this.iconColor, required this.title});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          iconShape,
          size: Dimensions.dim25,
          color: iconColor ?? AppColors.iconColorYellow,
        ),
        SmallText(
          title: title,
          fontSize: Dimensions.dim13,
        ),
        SizedBox(width: Dimensions.dim10)
      ],
    );
  }
}
