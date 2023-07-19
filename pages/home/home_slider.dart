// ignore_for_file: prefer_const_constructors

import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:instafood/controllers/popular_product_controller.dart';
import 'package:instafood/models/products_model.dart';
import 'package:instafood/routes/routes.dart';
import 'package:instafood/utils/app_constant.dart';
import 'package:instafood/utils/colors.dart';
import 'package:instafood/utils/dimensions.dart';
import 'package:instafood/widgets/app_column.dart';
import 'package:instafood/widgets/big_text.dart';
import 'package:instafood/widgets/icon_and_text.dart';
import 'package:instafood/widgets/small_text.dart';
import 'package:get/get.dart';

class HomeSlider extends StatefulWidget {
  const HomeSlider({
    super.key,
  });

  @override
  State<HomeSlider> createState() => _HomeSliderState();
}

class _HomeSliderState extends State<HomeSlider> {
  PageController pageController = PageController(viewportFraction: 0.85);
  var _currentPageValue = 0.0;
  final double _scaleFactor = 0.8;
  final _hieght = Dimensions.dim220.toInt();

  @override
  void initState() {
    pageController.addListener(() {
      setState(() {
        _currentPageValue = pageController.page!;
        // print(_currentPageValue);
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // ignore: sized_box_for_whitespace
        GetBuilder<PopularProductController>(builder: (popularProducts) {
          return Container(
            height: Dimensions.dim320,
            child: PageView.builder(
                //responsible to build and control horizontal scroll page
                controller: pageController,
                itemCount: popularProducts.popularProductList.length,
                itemBuilder: (context, index) {
                  return _scrollSection(index, popularProducts.popularProductList[index]);
                }),
          );
        }),
        GetBuilder<PopularProductController>(builder: (popularProducts) {
          return DotsIndicator(
            dotsCount: popularProducts.popularProductList.isEmpty
                ? 1
                : popularProducts.popularProductList.length,
            position: _currentPageValue,
            decorator: const DotsDecorator(
              color: Colors.grey, // Inactive color
              activeColor: AppColors.mainColor,
            ),
          );
        })
      ],
    );
  }

  Widget _scrollSection(int index, ProductModel productModel) {
    Matrix4 matrix = Matrix4.identity();
    if (index == _currentPageValue.floor()) {
      var currentScale = 1 - (_currentPageValue - index) * (1 - _scaleFactor);
      var currentTrans = _hieght * (1 - currentScale) / 2;
      matrix = Matrix4.diagonal3Values(1, currentScale, 1)..setTranslationRaw(0, currentTrans, 0);
    } else if (index == _currentPageValue.floor() + 1) {
      var currentScale = _scaleFactor + (_currentPageValue - index + 1) * (1 - _scaleFactor);
      var currentTrans = _hieght * (1 - currentScale) / 2;
      matrix = Matrix4.diagonal3Values(1, currentScale, 1);
      matrix = Matrix4.diagonal3Values(1, currentScale, 1)..setTranslationRaw(0, currentTrans, 1);
    } else {
      var currentScale = 0.8;
      matrix = Matrix4.diagonal3Values(1, currentScale, 1)
        ..setTranslationRaw(0, _hieght * (1 - currentScale) / 2, 1);
    }

    return Transform(
      transform: matrix,
      child: Stack(
        children: [
          GestureDetector(
            onTap: () {
              Get.toNamed(AppRoutes.getPopularFoodDetails(index)); // (1) it provides the (pageID)
            },
            child: Container(
                // if we didn't wrap this container with Stack() widget, it will take the same high of the parent widget
                height: Dimensions.dim220,
                margin: EdgeInsets.only(left: Dimensions.dim5, right: Dimensions.dim5),
                decoration: BoxDecoration(
                    // color: Colors.amber,
                    borderRadius: BorderRadius.circular(Dimensions.dim30),
                    image: DecorationImage(
                        fit: BoxFit.cover,
                        image:
                            NetworkImage(AppConstant.BASE_URL + "uploads/" + productModel.img!)))),
          ),
          Align(
              // this to align the child widget in the parent widget (hight: 320)
              alignment: Alignment.bottomCenter,
              child: Container(
                // if we didn't wrap this container with Stack() widget, it will take the same high of the parent widget
                height: Dimensions.dim140,
                margin: EdgeInsets.only(
                    left: Dimensions.dim30, right: Dimensions.dim30, bottom: Dimensions.dim10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(color: Colors.grey.shade200, blurRadius: 5, offset: Offset(0, 5))
                  ],
                  borderRadius: BorderRadius.circular(Dimensions.dim30),
                ),
                child: Padding(
                    padding: EdgeInsets.all(Dimensions.dim15),
                    child: AppColumn(title: productModel.name!)),
              )),
        ],
      ),
    );
  }
}
