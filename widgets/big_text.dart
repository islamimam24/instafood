// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:instafood/utils/dimensions.dart';

class BigText extends StatelessWidget {
  final String title;
  Color? color;
  double fontSize;
  TextOverflow overFlow;

  BigText(
      {super.key,
      required this.title,
      this.color, // you cant access some oher class for a default value
      this.fontSize = 0,
      this.overFlow = TextOverflow.ellipsis});

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: TextStyle(
        overflow: overFlow,
        color: color,
        fontSize: fontSize == 0 ? Dimensions.dim20 : fontSize,
      ),
    );
  }
}
