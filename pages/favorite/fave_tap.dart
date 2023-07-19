import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:instafood/controllers/auth_controller.dart';
import 'package:instafood/controllers/cart_controller.dart';
import 'package:instafood/controllers/recommended_products_controller.dart';
import 'package:instafood/controllers/users_data.dart';
import 'package:instafood/models/products_model.dart';
import 'package:instafood/routes/routes.dart';
import 'package:instafood/widgets/user_date_icon.dart';

import '../../models/cart_model.dart';
import '../../utils/app_constant.dart';
import '../../utils/colors.dart';
import '../../utils/dimensions.dart';
import '../../widgets/big_text.dart';
import '../../widgets/small_text.dart';

class FavTap extends StatefulWidget {
  const FavTap({Key? key}) : super(key: key);

  @override
  State<FavTap> createState() => _FavTapState();
}

class _FavTapState extends State<FavTap> {
  Future<void> loadData() async {
    await Get.find<UsersData>().getUsersData();
    await Get.find<RecommendedProductsController>().getSavedItemsFromCloud();
  }

  @override
  void initState() {
    super.initState();

    /// this line is for future init state .. this will update the screen once it finishes
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await loadData();
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    List<ProductModel> favoriteItems =
        Get.find<RecommendedProductsController>().favProducts!.reversed.toList();

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(40.0),
        child: AppBar(
          title: Text("Favorite"),
          backgroundColor: AppColors.mainColor,
          automaticallyImplyLeading: false,
        ),
      ),
      body: GetBuilder<RecommendedProductsController>(builder: (recommendedController) {
        return favoriteItems.isEmpty
            ? Center(
                child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: Dimensions.dim10),
                  SmallText(title: "Add your Favorite plates here.")
                ],
              ))
            : Padding(
                padding: EdgeInsets.only(top: Dimensions.dim10),
                child: ListView.builder(
                  itemCount: favoriteItems.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Dismissible(
                      key: UniqueKey(),
                      onDismissed: (direction) {
                        recommendedController.removeItemFromFaveList(favoriteItems[index]);
                        setState(() {});
                      },
                      background: Container(
                        color: Colors.red,
                      ),
                      child: Container(
                        margin: EdgeInsets.only(
                            top: Dimensions.dim15, left: Dimensions.dim15, right: Dimensions.dim15),
                        height: Dimensions.dim100,
                        width: double.maxFinite,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                  blurRadius: Dimensions.dim5,
                                  spreadRadius: Dimensions.dim5,
                                  offset: Offset(1, Dimensions.dim5),
                                  color: Colors.grey.withOpacity(.2))
                            ],
                            borderRadius: BorderRadius.circular(Dimensions.dim10)),
                        child: Row(
                          children: [
                            Container(
                              // margin: EdgeInsets.only(left: Dimensions.dim15),
                              height: Dimensions.dim100,
                              width: Dimensions.dim100,
                              // color: Colors.grey,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(Dimensions.dim10),
                                  image: DecorationImage(
                                    image: NetworkImage(
                                        "${AppConstant.BASE_URL}uploads/${favoriteItems[index].img!}"),
                                    fit: BoxFit.cover,
                                  )),
                            ),
                            SizedBox(width: Dimensions.dim10),
                            Expanded(
                              child: Column(
                                // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                // crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(height: Dimensions.dim5),
                                  Expanded(
                                    child: Row(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        BigText(title: favoriteItems[index].name.toString()),
                                      ],
                                    ),
                                  ),
                                  Expanded(
                                      child: SmallText(title: favoriteItems[index].description.toString())),
                                  Expanded(
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        GestureDetector(
                                          onTap: () {
                                            CartController cartController = Get.find<CartController>();
                                            cartController.clearItems();
                                            cartController.cartItems(favoriteItems[index], 1);
                                            Get.toNamed(AppRoutes.cartPage);
                                          },
                                          child: Container(
                                            width: Dimensions.dim120,
                                            height: Dimensions.dim50,
                                            decoration: BoxDecoration(
                                                color: AppColors.buttonColorRed,
                                                borderRadius:
                                                    BorderRadius.all(Radius.circular(Dimensions.dim10))),
                                            child: Center(
                                              child: BigText(
                                                title: "Order Again",
                                                color: AppColors.buttonText,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              );
      }),
    );
    // ]),
    // );
  }
}
