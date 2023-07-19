import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:instafood/controllers/popular_product_controller.dart';
import 'package:instafood/controllers/recommended_products_controller.dart';
import 'package:instafood/controllers/users_data.dart';
import 'package:instafood/pages/cart/cart_screen.dart';
import 'package:instafood/routes/routes.dart';
import 'package:instafood/utils/colors.dart';
import 'package:instafood/utils/dimensions.dart';
import 'package:instafood/widgets/app_icon.dart';
import 'package:instafood/widgets/big_text.dart';
import 'package:instafood/widgets/expandable_text.dart';
import 'package:instafood/widgets/small_text.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../controllers/auth_controller.dart';
import '../../controllers/cart_controller.dart';
import '../../utils/app_constant.dart';
import '../../widgets/snackbar.dart';
import '../signin/signin_page.dart';

class RecommendedFoodDetails extends StatefulWidget {
  var recommendedPageId;
  RecommendedFoodDetails({super.key, required this.recommendedPageId});
  @override
  State<RecommendedFoodDetails> createState() => _RecommendedFoodDetailsState();
}

class _RecommendedFoodDetailsState extends State<RecommendedFoodDetails> {
  var recommendedController = Get.find<RecommendedProductsController>();
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
    var recommendedProduct =
        recommendedController.recommendedProductList[int.parse(widget.recommendedPageId)];
    Get.find<PopularProductController>().initPage(recommendedProduct, Get.find<CartController>());
    Get.find<RecommendedProductsController>().isProductExist(recommendedProduct);

    return Scaffold(
        body: CustomScrollView(slivers: [
          SliverAppBar(
            automaticallyImplyLeading: false,
            toolbarHeight: Dimensions.dim70,
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () {
                    // Get.toNamed(RoutesHelper.initial);
                    Navigator.pop(context);
                  },
                  child: AppIcon(
                    icon: Icons.close,
                    bgColor: Colors.black.withOpacity(.5),
                  ),
                ),
                GetBuilder<PopularProductController>(builder: (controller) {
                  return Stack(children: [
                    GestureDetector(
                      onTap: () {
                        Get.toNamed(AppRoutes.cartPage);
                      },
                      child: AppIcon(
                        icon: Icons.shopping_cart_outlined,
                        bgColor: Colors.black.withOpacity(.5),
                      ),
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
                  ]);
                }),
              ],
            ),
            backgroundColor: AppColors.mainColor,
            pinned: true,
            expandedHeight: Dimensions.dim300,
            flexibleSpace: FlexibleSpaceBar(
              background: Image.network("${AppConstant.BASE_URL}uploads/${recommendedProduct.img!}",
                  fit: BoxFit.cover),
            ),
            bottom: PreferredSize(
              preferredSize: const Size.fromHeight(20),
              child: Container(
                width: double.maxFinite,
                height: Dimensions.dim40,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(Dimensions.dim20),
                        topRight: Radius.circular(Dimensions.dim20))),
                child: Center(child: BigText(title: recommendedProduct.name.toString())),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.only(left: Dimensions.dim10, right: Dimensions.dim10),
                  child: ExpandableText(text: recommendedProduct.description.toString()),
                ),
              ],
            ),
          ),
        ]),
        bottomNavigationBar: GetBuilder<PopularProductController>(
          builder: (controller) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Container(
                  color: Colors.white,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      GestureDetector(
                        onTap: () {
                          controller.setQuantity(false);
                        },
                        child: AppIcon(
                          icon: Icons.remove_circle,
                          iconColor: AppColors.mainColor,
                          iconSize: Dimensions.dim50,
                          bgColor: AppColors.iconColorWhite,
                        ),
                      ),
                      BigText(title: "\$ ${recommendedProduct.price} X ${controller.totalQuantity}"),
                      GestureDetector(
                        onTap: () {
                          controller.setQuantity(true);
                        },
                        child: AppIcon(
                          icon: Icons.add_circle,
                          iconColor: AppColors.mainColor,
                          iconSize: Dimensions.dim50,
                          bgColor: AppColors.iconColorWhite,
                        ),
                      )
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(Dimensions.dim25),
                  decoration: BoxDecoration(
                      color: Colors.grey.withOpacity(.2),
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(Dimensions.dim20),
                        topRight: Radius.circular(Dimensions.dim20),
                      )),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      GestureDetector(
                        onTap: () {
                          if (recommendedController.isExist == false) {
                            recommendedController.saveProductsToFavLists(recommendedProduct);
                          } else {
                            recommendedController.removeItemFromFaveList(recommendedProduct);
                          }
                          setState(() {});
                        },
                        child: Container(
                            height: Dimensions.dim50,
                            width: Dimensions.dim100,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(Dimensions.dim20),
                              color: recommendedController.isExist ? AppColors.mainColor : Colors.white,
                            ),
                            child: Icon(
                              Icons.favorite,
                              color: recommendedController.isExist ? Colors.white : AppColors.mainColor,
                            )),
                      ),
                      GestureDetector(
                        onTap: () {
                          controller.addItem(recommendedProduct);
                        },
                        child: Container(
                          height: Dimensions.dim50,
                          width: Dimensions.dim140,
                          decoration: BoxDecoration(
                              color: AppColors.mainColor,
                              borderRadius: BorderRadius.circular(Dimensions.dim20)),
                          child: Center(
                            child: BigText(
                              title: "\$ ${recommendedProduct.price}  add to cart",
                              fontSize: Dimensions.dim15,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            );
          },
        ));
  }
}
