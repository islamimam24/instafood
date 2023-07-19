import 'package:flutter/material.dart';
import 'package:instafood/controllers/cart_controller.dart';
import 'package:instafood/pages/signin/signin_page.dart';
import 'package:instafood/routes/routes.dart';

// import 'package:flutter/src/widgets/framework.dart';
// import 'package:flutter/src/widgets/placeholder.dart';
// import 'package:flutter/widgets.dart';
import 'package:instafood/utils/dimensions.dart';
import 'package:instafood/widgets/app_column.dart';
import 'package:instafood/widgets/big_text.dart';
import 'package:instafood/widgets/expandable_text.dart';
import 'package:instafood/widgets/snackbar.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../controllers/auth_controller.dart';
import '../../controllers/popular_product_controller.dart';
import '../../utils/app_constant.dart';
import '../../utils/colors.dart';
import '../../widgets/app_icon.dart';
import '../../widgets/icon_and_text.dart';
import '../../widgets/small_text.dart';

class PopularFoodDetails extends StatelessWidget {
  var pageIndex;

  PopularFoodDetails(
      {super.key, required this.pageIndex}); // (6) catches the value from routes.dart

  @override
  Widget build(BuildContext context) {
    var popularProduct = Get.find<PopularProductController>().popularProductList[
        int.parse(pageIndex)]; // accessing the list from PopularProductController() by pageIndex
    Get.find<PopularProductController>().initPage(popularProduct, Get.find<CartController>());
    var authController = Get.find<AuthController>();
    return Scaffold(
        body: Stack(
          children: [
            Positioned(
                left: 0,
                right: 0,
                child: Container(
                  height: Dimensions.dim320,
                  width: double.maxFinite,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          fit: BoxFit.cover,
                          image: NetworkImage(
                              "${AppConstant.BASE_URL}uploads/${popularProduct.img!}"))),
                )),
            Positioned(
                left: Dimensions.dim30,
                top: Dimensions.dim60,
                child: GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                    // Get.toNamed(RoutesHelper.getHomeScreen());
                  },
                  child: AppIcon(
                    icon: Icons.arrow_back_ios_new,
                    bgColor: Colors.black.withOpacity(.5),
                  ),
                )),
            GetBuilder<PopularProductController>(builder: (controller) {
              return Stack(children: [
                Positioned(
                    right: Dimensions.dim30,
                    top: Dimensions.dim60,
                    child: GestureDetector(
                      onTap: () {
                        Get.toNamed(AppRoutes.cartPage);
                      },
                      child: AppIcon(
                        icon: Icons.shopping_cart_outlined,
                        bgColor: Colors.black.withOpacity(.5),
                      ),
                    )),
                controller.totalItems >= 1
                    ? Positioned(
                        right: Dimensions.dim30,
                        top: Dimensions.dim60,
                        child: Container(
                          height: Dimensions.dim20,
                          width: Dimensions.dim20,
                          decoration: BoxDecoration(
                              color: AppColors.mainColor,
                              borderRadius: BorderRadius.circular(Dimensions.dim10)),
                          child: Center(
                            child: SmallText(
                              title: controller.totalItems.toString(),
                              color: Colors.white,
                            ),
                          ),
                        ))
                    : Container(),
              ]);
            }),
            Positioned(
                top: Dimensions.dim300,
                left: 0,
                right: 0,
                bottom: Dimensions.dim10,
                child: Container(
                    padding: EdgeInsets.only(
                      top: Dimensions.dim20,
                      left: Dimensions.dim20,
                    ),
                    decoration: BoxDecoration(
                        color: Colors.white, borderRadius: BorderRadius.circular(Dimensions.dim20)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AppColumn(title: popularProduct.name.toString()),
                        SizedBox(height: Dimensions.dim20),
                        BigText(title: "Introduce"),
                        Container(
                          height: Dimensions.dim250,
                          child: ExpandableText(text: popularProduct.description.toString()),
                        ),
                      ],
                    )))
          ],
        ),
        // to run update method you have to hotReload the app or wrap whatever widget you will use this function at, with GetBuilder()
        bottomNavigationBar: GetBuilder<PopularProductController>(
          builder: (popularController) {
            return Container(
              height: Dimensions.dim120,
              color: Colors.grey.withOpacity(0.2),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                    height: Dimensions.dim50,
                    width: Dimensions.dim100,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(Dimensions.dim20),
                      color: Colors.white,
                    ),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          GestureDetector(
                              onTap: () {
                                popularController.setQuantity(false);
                              },
                              child: Icon(Icons.minimize)),
                          BigText(title: popularController.totalQuantity.toString()),
                          GestureDetector(
                              onTap: () {
                                popularController.setQuantity(true);
                              },
                              child: Icon(Icons.add))
                        ]),
                  ),
                  GestureDetector(
                    onTap: () {
                      popularController.addItem(popularProduct);

                      // var currentUser = authController.getCurrentUserModel.email == null
                      //     ? authController.googleCurrentUserModel
                      //     : authController.getCurrentUserModel;
                      //
                      // if (currentUser?.email == null) {
                      //   errorSnackBar("you should Sign in to use this feature");
                      //   Get.toNamed(AppRoutes.signInPage);
                      // } else {
                      //   popularController.addItem(popularProduct);
                      // }
                    },
                    child: Container(
                      height: Dimensions.dim50,
                      width: Dimensions.dim140,
                      decoration: BoxDecoration(
                          color: AppColors.mainColor,
                          borderRadius: BorderRadius.circular(Dimensions.dim20)),
                      child: Center(
                        child: BigText(
                          title: "\$  ${popularProduct.price} add to cart",
                          fontSize: Dimensions.dim15,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            );
          },
        ));
  }
}
