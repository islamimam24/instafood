import 'package:get/get.dart';
import 'package:instafood/controllers/popular_product_controller.dart';
import 'package:instafood/controllers/recommended_products_controller.dart';
import 'package:instafood/controllers/users_data.dart';

import '../data/repository/cart_repo.dart';
import '../models/cart_model.dart';
import '../models/products_model.dart';
import '../models/user_model.dart';
import 'cart_controller.dart';

class CartHistoryController {
  CartRepo cartRepo;
  UsersData usersDataIns;
  CartController cartCottroller;

  CartHistoryController({required this.cartRepo, required this.usersDataIns, required this.cartCottroller});
  List<CartModel> _historyStorage = [];
  List<CartModel> _cartListStorage = [];
  Map<int, CartModel> _items = {};

  List<CartModel> _currentUserCartHistoryAPI = [];
  Map orderedCartItemsByTime = {};
  get getItems => cartCottroller.items;
  set setCartHistory(List<CartModel> list) {
    _historyStorage = [];
    _historyStorage = list;
  }

  set setCartList(List<CartModel> items) {
    _items = getItems;
    _cartListStorage = items;
    for (var i = 0; i < _cartListStorage.length; i++) {
      _items.putIfAbsent(_cartListStorage[i].id!, () => _cartListStorage[i]);
    }
  }

  List<CartModel> get getCartListStorage {
    _cartListStorage = [];
    setCartList = cartRepo.getCartList(usersDataIns.getCurrentUserModel!);

    return _cartListStorage;
  }

  List<CartModel> get getCurrentUserCartHistoryAPI => _currentUserCartHistoryAPI; // _userCartHistory

  getItemsHistoryFromApi() async {
    _currentUserCartHistoryAPI = [];
    List<CartModel>? userCart = [];
    if (usersDataIns.usersData[usersDataIns.getCurrentUserModel?.email] != null) {
      var userDataValue = usersDataIns.usersData[usersDataIns.getCurrentUserModel?.email];
      if (userDataValue.runtimeType == UserModel) {
        userCart = userDataValue.cartModelList;
      } else {
        userCart = UserModel.fromJson(userDataValue).cartModelList;
      }
      _currentUserCartHistoryAPI.addAll(userCart?.reversed.toList() as Iterable<CartModel>);
    }
  }

  /// cart List Storage

  // getProductModel(int id) {
  //   List<ProductModel> allProductsList = [];
  //   ProductModel? productModel;
  //
  //   Map mapAll = {};
  //   var pop = Get.find<PopularProductController>().popularProductList;
  //   var rec = Get.find<RecommendedProductsController>().recommendedProductList;
  //   allProductsList.addAll(pop);
  //   allProductsList.addAll(rec);
  //   allProductsList.forEach((element) {
  //     mapAll.addAll(element.toJson());
  //   });
  //   for (var element in allProductsList) {
  //     if (element.id == id) {
  //       productModel = element;
  //     }
  //   }
  //   return productModel;
  // }

  addToCartModelListPropertyCloud(List<CartModel> productsList) {
    List<CartModel> currentCartList = [];
    var currentList;
    usersDataIns.usersData.forEach((key, value) {
      if (key == usersDataIns.getCurrentUserModel?.email) {
        Map<String, dynamic> currentUserData = usersDataIns.usersData[key].runtimeType == UserModel
            ? usersDataIns.usersData[key].toJson()
            : usersDataIns.usersData[key];

        currentList = currentUserData["cartModelList"];
        if (currentList.runtimeType == List<CartModel>) {
          currentList.forEach((element) => currentCartList.add(element));
        } else if (currentList != null) {
          currentList.forEach((element) => currentCartList.add(CartModel.fromJson(element)));
        }
        productsList.forEach((element) => currentCartList.add(element));
      }
    });
    usersDataIns.updateUserData(property: "cartModelList", setValue: currentCartList);
    currentCartList.forEach((element) {});
    return currentCartList;
  }

  timeOrderedItems() {
    orderedCartItemsByTime = {};
    try {
      for (var i = 0; i < getCurrentUserCartHistoryAPI.length; i++) {
        if (orderedCartItemsByTime.containsKey(getCurrentUserCartHistoryAPI[i].time)) {
          orderedCartItemsByTime.update(getCurrentUserCartHistoryAPI[i].time, (value) => ++value);
        } else {
          orderedCartItemsByTime.putIfAbsent(getCurrentUserCartHistoryAPI[i].time, () => 1);
        }
      }
      return orderedCartItemsByTime;
    } catch (e) {}
  }

  Future<void> loadSources() async {
    Get.find<UsersData>().getCurrentUserModel;
    getItemsHistoryFromApi();
    timeOrderedItems();
  }
}
