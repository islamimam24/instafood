import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:instafood/controllers/auth_controller.dart';
import 'package:instafood/controllers/cart_controller.dart';
import 'package:instafood/controllers/cart_history_controller.dart';
import 'package:instafood/controllers/users_data.dart';
import 'package:instafood/models/cart_model.dart';
import 'package:instafood/models/user_model.dart';
import 'package:instafood/routes/routes.dart';
import 'package:instafood/utils/colors.dart';
import 'package:instafood/widgets/big_text.dart';
import 'package:instafood/widgets/no_data_widget.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../utils/app_constant.dart';
import '../../utils/dimensions.dart';
import '../../widgets/small_text.dart';

class CartHistory extends StatefulWidget {
  const CartHistory({Key? key}) : super(key: key);

  @override
  State<CartHistory> createState() => _CartHistoryState();
}

class _CartHistoryState extends State<CartHistory> {
  UserModel? currentUserModel = Get.find<UsersData>().getCurrentUserModel;

  @override
  void initState() {
    Get.find<CartHistoryController>().loadSources();
    super.initState();
  }

  @override
  build(BuildContext context) {
    var cartHistoryList = Get.find<CartHistoryController>().getCurrentUserCartHistoryAPI;
    Map cartItemsPerOrder = Get.find<CartHistoryController>().orderedCartItemsByTime;

    var timeOfCartItemPerOrder = cartItemsPerOrder.entries.map((e) => e.key).toList();
    var numOfCartItemPerOrder = cartItemsPerOrder.entries.map((e) => e.value).toList();
    // print(timeOfCartItemPerOrder);
    var counter = 0;
    return GetBuilder<CartController>(builder: (cartController) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            height: Dimensions.dim100,
            color: AppColors.mainColor,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                    padding: EdgeInsets.only(bottom: Dimensions.dim10),
                    child: BigText(
                      title: "Cart History",
                      color: Colors.white,
                    )),
              ],
            ),
          ),
          Expanded(
              child: currentUserModel?.email == null ||
                      cartHistoryList.isEmpty ||
                      numOfCartItemPerOrder.isEmpty
                  ? Center(
                      child: NoDataPage(
                      title: "you haven't buy anything so far!",
                      imgPath: "assets/images/emptyBox.jpg",
                    ))
                  : ListView(
                      children: [
                        for (var i = 0; i < numOfCartItemPerOrder.length; i++)
                          Padding(
                              padding: EdgeInsets.only(left: Dimensions.dim10, right: Dimensions.dim10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  /// invoke some dart code inside here before returning a widget
                                  (() {
                                    var parseDate = DateFormat(("yyyy-MM-dd HH:mm:ss"))
                                        .parse(timeOfCartItemPerOrder[i].toString());
                                    String date = DateFormat(parseDate.toString()).toString();
                                    var outputFormat = DateFormat(("yyyy-MM-dd | HH:mm a "));
                                    var outputDate = outputFormat.format(parseDate);
                                    return BigText(title: outputDate.toString());
                                  }()),
                                  SizedBox(height: Dimensions.dim10),

                                  ///items images
                                  Container(
                                    height: Dimensions.dim120,
                                    // color: Colors.cyan,
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Expanded(
                                            child: Wrap(
                                                direction: Axis.horizontal,
                                                children: List.generate(numOfCartItemPerOrder[i], (index) {
                                                  if (counter < cartHistoryList.length) {
                                                    counter++;
                                                  }

                                                  return index < 3
                                                      ? Container(
                                                          margin: EdgeInsets.only(left: Dimensions.dim15),
                                                          height: Dimensions.dim80,
                                                          width: Dimensions.dim80,
                                                          // color: Colors.grey,
                                                          decoration: BoxDecoration(
                                                              borderRadius:
                                                                  BorderRadius.circular(Dimensions.dim30),
                                                              image: DecorationImage(
                                                                image: NetworkImage(
                                                                    "${AppConstant.BASE_URL}uploads/${cartHistoryList[counter - 1].img!}"),
                                                                fit: BoxFit.cover,
                                                              )),
                                                        )
                                                      : Container();
                                                }))),
                                        Container(
                                            margin: EdgeInsets.only(
                                                top: Dimensions.dim10, bottom: Dimensions.dim10),
                                            child: Column(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                SmallText(title: "total", color: Colors.black),
                                                BigText(title: "${numOfCartItemPerOrder[i]} Items"),
                                                GestureDetector(
                                                  onTap: () {
                                                    Map<int, CartModel> orderedItems = {};
                                                    for (var j = 0; j < cartHistoryList.length; j++) {
                                                      if (cartHistoryList[j].time ==
                                                          timeOfCartItemPerOrder[i]) {
                                                        orderedItems.putIfAbsent(
                                                            cartHistoryList[j].id!, () => cartHistoryList[j]);
                                                      }
                                                    }
                                                    cartController.clearItems();
                                                    cartController.setItems = orderedItems;
                                                    Get.toNamed(AppRoutes.cartPage);
                                                  },
                                                  child: Container(
                                                    height: Dimensions.dim30,
                                                    width: Dimensions.dim80,
                                                    decoration: BoxDecoration(
                                                      color: AppColors.mainColor,
                                                      borderRadius: BorderRadius.circular(Dimensions.dim10),
                                                    ),
                                                    child: Center(
                                                      child: SmallText(
                                                        title: "Add More",
                                                        color: Colors.white,
                                                      ),
                                                    ),
                                                  ),
                                                )
                                              ],
                                            )),
                                      ],
                                    ),
                                  )
                                ],
                              ))
                      ],
                    )),
        ],
      );
    });
  }
}
