import 'package:flutter/rendering.dart';
import 'package:instafood/controllers/auth_controller.dart';
import 'package:instafood/controllers/users_data.dart';
import 'package:instafood/data/repository/recommended_product_repo.dart';
import 'package:instafood/models/cart_model.dart';
import 'package:instafood/models/products_model.dart';
import 'package:get/get.dart';
import 'package:instafood/models/user_model.dart';

import 'cart_controller.dart';

class RecommendedProductsController extends GetxController {
  RecommendedProductRepo recommendedProductRepo;
  UsersData usersDataIns;

  RecommendedProductsController({required this.recommendedProductRepo, required this.usersDataIns});
  List<ProductModel> _recommendedProductList = [];
  bool _isLoaded = false;
  List<ProductModel> savedFaveItems = [];

  bool get isLoaded => _isLoaded;
  Map<String, dynamic> get usersData => usersDataIns.usersData;
  List<ProductModel>? favProducts = [];
  bool isExist = false;
  List<ProductModel> get recommendedProductList => _recommendedProductList;

  Future<void> getRecommendedProductsList() async {
    Response response = await recommendedProductRepo.recommendedProductList();
    if (response.statusCode == 200) {
      _recommendedProductList = [];
      _recommendedProductList.addAll(Product.fromJson(response.body).products as Iterable<ProductModel>);
      _isLoaded = true;
    } else {}
  }

  getSavedItemsFromCloud() async {
    favProducts = [];
    var userData = await usersData[Get.find<UsersData>().getUserLoginEmail];
    if (userData != null) {
      if (userData.runtimeType == UserModel) {
        favProducts = userData.favProductList;
      } else {
        UserModel userModel = UserModel.fromJson(userData);
        favProducts = userModel.favProductList;
      }
    }
    update();

    return favProducts;
  }

  // saveProductToCloud(ProductModel productModel) {
  //   ;
  //
  //   _recommendedProductList.forEach((element) {
  //     if (productModel.id == element.id) {
  //       productModel = element;
  //     }
  //   });
  //   saveProductsToFavLists(productModel);
  //   update();
  //   return productModel;
  // }

  // saveFaveItems(ProductModel productModel) {
  //   if (savedFaveItems.isEmpty) {
  //     savedFaveItems.add(productModel);
  //   } else {
  //     if (savedFaveItems.contains(productModel)) {
  //       print("exists");
  //     } else {
  //       savedFaveItems.add(productModel);
  //     }
  //   }
  //   updateUserDataByFavList();
  //   update();
  // }

  removeItemFromFaveList(ProductModel productModel) {
    // favProducts?.forEach((element) {
    //   print("before ${element.name}");
    // });
    // favProducts?.remove(productModel);
    // favProducts?.forEach((element) {
    //   print("after ${element.name}");
    // });
    for (var element in favProducts!) {
      if (element.id == productModel.id) {
        favProducts!.removeAt(favProducts!.indexOf(element));
        break;
      }
    }
    Get.find<UsersData>().updateUserData(property: "favProductList", setValue: favProducts);
    update();
  }

  saveProductsToFavLists(ProductModel productModel) {
    bool isExist = false;
    if (favProducts!.isEmpty) {
      print("added to face from null");
      addToFavoriteMap(productModel);
      favProducts?.add(productModel);
    } else {
      for (var element in favProducts!) {
        if (element.id == productModel.id) {
          isExist = true;
          break;
        } else if (isExist == false && favProducts?.indexOf(element) == favProducts!.length - 1) {
          addToFavoriteMap(productModel);
          favProducts?.add(productModel);
          update();
          break;
        }
      }
    }
    update();
  }

  addToFavoriteMap(ProductModel poductModel) {
    List<ProductModel> currentCartList = [];
    var currentList;
    usersData.forEach((key, value) {
      if (key == usersDataIns.getCurrentUserModel?.email) {
        Map<String, dynamic> currentUserData =
            usersData[key].runtimeType == UserModel ? usersData[key].toJson() : usersData[key];

        currentList = currentUserData["favProductList"];

        if (currentList.runtimeType == List<ProductModel>) {
          currentList.forEach((element) => currentCartList.add(element));
        } else {
          currentList.forEach((element) => currentCartList.add(ProductModel.fromJson(element)));
        }
        currentCartList.add(poductModel);
      }
    });
    usersDataIns.updateUserData(property: "favProductList", setValue: currentCartList);
    return currentCartList;
  }

  bool isProductExist(ProductModel productModel) {
    isExist = false;
    if (favProducts!.isEmpty) {
      isExist = false;
    } else {
      for (var element in favProducts!) {
        if (element.id == productModel.id) {
          isExist = true;
          break;
        }
      }
    }
    return isExist;
  }
}
