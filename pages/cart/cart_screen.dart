import 'package:flutter/material.dart';
import 'package:instafood/controllers/auth_controller.dart';
import 'package:instafood/controllers/cart_controller.dart';
import 'package:instafood/controllers/cart_history_controller.dart';
import 'package:instafood/controllers/popular_product_controller.dart';
import 'package:instafood/controllers/recommended_products_controller.dart';
import 'package:instafood/controllers/users_data.dart';
import 'package:instafood/models/products_model.dart';
import 'package:instafood/pages/cart/cart_history.dart';
import 'package:instafood/pages/home/main_home_screen.dart';
import 'package:instafood/widgets/app_icon.dart';
import 'package:instafood/widgets/big_text.dart';
import 'package:instafood/widgets/no_data_widget.dart';
import 'package:instafood/widgets/small_text.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../controllers/cart_controller.dart';
import '../../routes/routes.dart';
import '../../utils/app_constant.dart';
import '../../utils/colors.dart';
import '../../utils/dimensions.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CartController>(builder: (cartController) {
      // cartController.getCurrentUser();
      Get.find<UsersData>().getCurrentUserModel;
      return Scaffold(
          backgroundColor: Colors.white,
          body: SafeArea(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                    GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: AppIcon(icon: Icons.arrow_back_ios)),
                    GestureDetector(
                        onTap: () {
                          Get.toNamed(AppRoutes.getHome());
                        },
                        child: AppIcon(icon: Icons.home)),
                    GetBuilder<PopularProductController>(builder: (controller) {
                      return GestureDetector(
                        onTap: () {
                          Get.find<CartHistoryController>().getCartListStorage;
                        },
                        child: Stack(children: [
                          AppIcon(
                            icon: Icons.shopping_cart_outlined,
                            bgColor: AppColors.iconColorRed,
                            iconColor: AppColors.iconColorWhite,
                          ),
                          controller.totalItems >= 1
                              ? Container(
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
                                )
                              : Container(),
                        ]),
                      );
                    }),
                  ]),
                ),
                SizedBox(height: Dimensions.dim15),
                Expanded(
                  child: cartController.getItems.isEmpty
                      ? Padding(
                          padding: EdgeInsets.only(bottom: Dimensions.dim20),
                          child: NoDataPage(
                            title: "your cart is Empty",
                            imgPath: "assets/images/emptyCart.jpg",
                          ),
                        )
                      : ListView.builder(
                          itemCount: cartController.getItems.length,
                          itemBuilder: (context, index) {
                            var cartItem = cartController.getItems[index];
                            ProductModel productModel = cartController.getItems[index].productModel;
                            return GestureDetector(
                              onTap: () {
                                var popularPageIndex = Get.find<PopularProductController>()
                                    .popularProductList
                                    .indexOf(productModel);
                                if (popularPageIndex >= 0) {
                                  // print(" this is index $popularPageIndex");
                                  Get.toNamed(AppRoutes.getPopularFoodDetails(popularPageIndex));
                                } else {
                                  var recommendedPageIndex = Get.find<RecommendedProductsController>()
                                      .recommendedProductList
                                      .indexOf(productModel);
                                  if (recommendedPageIndex >= 0) {
                                    Get.toNamed(AppRoutes.getRecommendedFoodDetails(recommendedPageIndex));
                                  } else {
                                    Get.snackbar(
                                        "Warning!", "you only can change th quantity to order for this item");
                                  }
                                }
                              },
                              child: Container(
                                margin: EdgeInsets.only(
                                    bottom: Dimensions.dim10,
                                    left: Dimensions.dim10,
                                    right: Dimensions.dim10),
                                height: Dimensions.dim150,
                                child: Row(children: [
                                  Container(
                                    width: Dimensions.dim150,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(Dimensions.dim30),
                                        image: DecorationImage(
                                          image: NetworkImage(
                                              "${AppConstant.BASE_URL}uploads/${cartController.getItems[index].img!}"),
                                          fit: BoxFit.cover,
                                        )),
                                  ),
                                  SizedBox(
                                    width: Dimensions.dim10,
                                  ),
                                  Expanded(
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        BigText(title: cartController.getItems[index].name.toString()),
                                        SmallText(title: "Spicy"),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            BigText(
                                              title: "\$${cartController.getItems[index].price}",
                                              color: Colors.green.shade700,
                                            ),
                                            Row(
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
                                                              try {
                                                                cartController.cartItems(
                                                                    productModel,
                                                                    cartController.getQuantity(productModel) -
                                                                        1);
                                                                cartItem.price! * (cartItem.quantity! - 1);
                                                              } catch (e) {
                                                                print(e);
                                                              }
                                                            },
                                                            child: Icon(Icons.minimize)),
                                                        BigText(title: cartItem.quantity.toString()),
                                                        GestureDetector(
                                                            onTap: () {
                                                              try {
                                                                cartController.cartItems(
                                                                    productModel,
                                                                    cartController.getQuantity(productModel) +
                                                                        1);
                                                                var itemAount = cartItem.price! *
                                                                    (cartItem.quantity! + 1);
                                                              } catch (e) {
                                                                print("CartScreen $e");
                                                              }
                                                            },
                                                            child: Icon(Icons.add))
                                                      ]),
                                                ),
                                              ],
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                  )
                                ]),
                              ),
                            );
                          }),
                )
              ],
            ),
          ),
          bottomNavigationBar: GetBuilder<CartController>(builder: (cartController) {
            return Container(
              height: Dimensions.dim120,
              color: Colors.grey.withOpacity(0.2),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                    height: Dimensions.dim50,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(Dimensions.dim20),
                      color: Colors.white,
                    ),
                    child: Center(
                        child: Padding(
                      padding: EdgeInsets.only(left: Dimensions.dim15, right: Dimensions.dim15),
                      child: BigText(
                        title: "\$ ${cartController.totalAmount.toString()}",
                        color: Colors.green.shade700,
                      ),
                    )),
                  ),
                  GestureDetector(
                    onTap: () {
                      // cartController.addToCartHistory();
                      // cartController.setCartHistoryOnCloud();
                      cartController.checkout();
                    },
                    // onDoubleTap: () {
                    //   cartController.clearHistoryListPreferences();
                    // },
                    child: Container(
                      height: Dimensions.dim50,
                      width: Dimensions.dim140,
                      decoration: BoxDecoration(
                          color: AppColors.mainColor, borderRadius: BorderRadius.circular(Dimensions.dim20)),
                      child: Center(
                        child: BigText(
                          title: "Checkout",
                          fontSize: Dimensions.dim15,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            );
          }));
    });
  }
}
