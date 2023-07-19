import 'package:flutter/material.dart';

import 'package:instafood/widgets/small_text.dart';

import '../utils/colors.dart';
import '../utils/dimensions.dart';
import 'big_text.dart';
import 'icon_and_text.dart';

class AppColumn extends StatelessWidget {
  final String title;
  const AppColumn({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        BigText(title: title),
        SizedBox(height: Dimensions.dim10),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Wrap(
                children: List.generate(
                    5,
                    (index) =>
                        Icon(Icons.star, size: Dimensions.dim15, color: AppColors.mainColor))),
            SizedBox(width: Dimensions.dim10),
            SmallText(title: "4.5"),
            SizedBox(width: Dimensions.dim10),
            SmallText(title: "1283"),
            SizedBox(width: Dimensions.dim5),
            SmallText(title: "Comments"),
            SizedBox(height: Dimensions.dim15),
          ],
        ),
        SizedBox(height: Dimensions.dim15),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          // ignore: prefer_const_literals_to_create_immutables
          children: [
            IconAndTextIcon(
              iconShape: Icons.circle,
              iconColor: AppColors.iconColorYellow,
              title: "Normal",
            ),
            IconAndTextIcon(
              iconShape: Icons.location_pin,
              iconColor: AppColors.iconColorRed,
              title: "1.7Km",
            ),
            IconAndTextIcon(
              iconShape: Icons.timer_outlined,
              iconColor: AppColors.mainColor,
              title: "32min",
            ),
          ],
        ),
      ],
    );
  }
}
