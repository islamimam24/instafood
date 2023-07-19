// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

import '../utils/dimensions.dart';

class SmallText extends StatelessWidget {
  final String title;
  Color? color;
  double? fontSize;
  TextOverflow overFlow;
  double hight;

  SmallText(
      {super.key,
      required this.title,
      this.color = const Color(0xFFA99A94), // you cant access some oher class for a default value
      this.fontSize = 0,
      this.overFlow = TextOverflow.ellipsis,
      this.hight = 1});

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: TextStyle(
        height: hight,
        color: color,
        fontSize: fontSize == 0 ? Dimensions.dim15 : fontSize,
      ),
      overflow: overFlow,
    );
  }
}
