// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:instafood/controllers/recommended_products_controller.dart';
import 'package:instafood/routes/routes.dart';
import 'package:instafood/utils/colors.dart';
import 'package:instafood/utils/dimensions.dart';
import 'package:instafood/widgets/big_text.dart';
import 'package:instafood/widgets/icon_and_text.dart';
import 'package:instafood/widgets/small_text.dart';
import 'package:get/get.dart';

import '../../utils/app_constant.dart';
import 'home_slider.dart';
import 'home_head.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: AppColors.beforeHomeColor,
      body: SafeArea(
        child: Column(
          children: [
            //head section
            HomeHead(),
            // body section
            // slider section
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    HomeSlider(),
                    Container(
                      margin: EdgeInsets.all(Dimensions.dim20),
                      child: Row(
                        // mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          BigText(title: "Recommended"),
                          SizedBox(width: Dimensions.dim10),
                          SmallText(title: "food Pairing")
                        ],
                      ),
                    ),
                    // recommended food page
                    GetBuilder<RecommendedProductsController>(builder: (recommendedProduct) {
                      return recommendedProduct.isLoaded
                          ? ListView.builder(
                              physics: NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              // must be true if you are not put this ListView.builder in a container
                              itemCount: recommendedProduct.recommendedProductList.length,
                              itemBuilder: (context, index) {
                                return GestureDetector(
                                  onTap: () {
                                    Get.toNamed(AppRoutes.getRecommendedFoodDetails(index));
                                  },
                                  child: Container(
                                    margin: EdgeInsets.only(left: Dimensions.dim20),
                                    child: Column(
                                      children: [
                                        Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                                          // showing list image
                                          Container(
                                            height: Dimensions.dim120,
                                            width: Dimensions.dim120,
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.only(
                                                  topLeft: Radius.circular(Dimensions.dim20),
                                                  bottomLeft: Radius.circular(Dimensions.dim20)),
                                              color: Colors.white,
                                              image: DecorationImage(
                                                  fit: BoxFit.cover,
                                                  image: NetworkImage(
                                                      "${AppConstant.BASE_URL}uploads/${recommendedProduct.recommendedProductList[index].img!}")),
                                            ),
                                          ),

                                          // showing list text column
                                          Expanded(
                                            child: Container(
                                              height: Dimensions.dim120,
                                              margin: EdgeInsets.only(
                                                  left: Dimensions.dim10, right: Dimensions.dim10),
                                              decoration: BoxDecoration(
                                                  // color: AppColors.beforeHomeColor,
                                                  borderRadius: BorderRadius.only(
                                                topRight: Radius.circular(Dimensions.dim20),
                                                bottomRight: Radius.circular(Dimensions.dim20),
                                              )),
                                              child: Column(
                                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  BigText(
                                                      title: recommendedProduct
                                                          .recommendedProductList[index].name!),
                                                  SmallText(
                                                      title:
                                                          "some discription for this meal some discription for this meal"),
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.spaceEvenly,
                                                    // ignore: prefer_const_literals_to_create_immutables
                                                    children: [
                                                      IconAndTextIcon(
                                                        iconShape: Icons.circle,
                                                        title: "Normal",
                                                      ),
                                                      IconAndTextIcon(
                                                        iconShape: Icons.location_on,
                                                        iconColor: AppColors.iconColorRed,
                                                        title: "1.7Km",
                                                      ),
                                                      IconAndTextIcon(
                                                        iconShape: Icons.timer_outlined,
                                                        iconColor: AppColors.iconColorRed,
                                                        title: "32min",
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ]),
                                        SizedBox(height: 20)
                                      ],
                                    ),
                                  ),
                                );
                              })
                          : CircularProgressIndicator();
                    }),
                    // SizedBox(height: 20)
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
