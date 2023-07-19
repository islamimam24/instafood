// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:instafood/utils/colors.dart';
import 'package:instafood/utils/dimensions.dart';
import 'package:instafood/widgets/big_text.dart';

import '../../widgets/small_text.dart';

class HomeHead extends StatelessWidget {
  const HomeHead({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          margin: EdgeInsets.all(Dimensions.dim10),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                BigText(
                  title: "Egypt",
                  color: AppColors.mainColor,
                ),
                SmallText(
                  title: "cairo",
                )
              ]),
        ),
        Container(
          width: Dimensions.dim45,
          height: Dimensions.dim45,
          margin: EdgeInsets.all(Dimensions.dim10),
          decoration: BoxDecoration(
              color: AppColors.mainColor,
              borderRadius: BorderRadius.circular(Dimensions.dim15)),
          child: Icon(
            Icons.search,
            color: Colors.white,
          ),
        ),
      ],
    );
  }
}
