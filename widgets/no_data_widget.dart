import 'package:flutter/material.dart';
import 'package:instafood/widgets/big_text.dart';
import 'package:instafood/widgets/small_text.dart';

class NoDataPage extends StatelessWidget {
  String? title, imgPath;

  NoDataPage({
    Key? key,
    this.title,
    this.imgPath,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Image.asset(
          imgPath.toString(),
          height: MediaQuery.of(context).size.height * .22,
          width: MediaQuery.of(context).size.height * .22,
        ),
        SmallText(title: title.toString())
      ],
    );
  }
}
