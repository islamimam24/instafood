import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter/widgets.dart';
import 'package:instafood/utils/colors.dart';
import 'package:instafood/widgets/small_text.dart';

import '../utils/dimensions.dart';

class ExpandableText extends StatefulWidget {
  final String text;

  const ExpandableText({super.key, required this.text});

  @override
  State<ExpandableText> createState() => _ExpandableTextState();
}

class _ExpandableTextState extends State<ExpandableText> {
  late String firstHalf;
  late String secondHalf;
  double textHight = Dimensions.dim220;
  bool hiddenText = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    if (widget.text.length > textHight) {
      hiddenText = true;
      firstHalf = widget.text.substring(0, textHight.toInt());
      secondHalf =
          widget.text.substring(textHight.toInt() + 1, widget.text.length);
    } else {
      hiddenText = false;
      firstHalf = widget.text;
      secondHalf = "";
    }
  }

  @override
  Widget build(BuildContext context) {
    return secondHalf.isEmpty
        ? Text(widget.text)
        : SingleChildScrollView(
            child: Column(children: [
              SmallText(
                title: hiddenText ? "$firstHalf..." : "$firstHalf+$secondHalf",
                overFlow: TextOverflow.clip,
                hight: 1.5,
              ),
              InkWell(
                onTap: () {
                  setState(() {
                    hiddenText = !hiddenText;
                  });
                },
                child: Row(
                  children: [
                    SmallText(
                      title: hiddenText ? "See More" : "See Less",
                      color: AppColors.mainColor,
                    ),
                    hiddenText
                        ? Icon(Icons.arrow_drop_down_outlined)
                        : Icon(Icons.arrow_drop_up_sharp)
                  ],
                ),
              )
            ]),
          );
  }
}
