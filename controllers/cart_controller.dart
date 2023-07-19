import 'package:firebase_auth/firebase_auth.dart';
import 'package:instafood/controllers/auth_controller.dart';
import 'package:instafood/controllers/cart_history_controller.dart';
import 'package:instafood/controllers/popular_product_controller.dart';
import 'package:instafood/controllers/recommended_products_controller.dart';
import 'package:instafood/controllers/users_data.dart';
import 'package:instafood/data/repository/cart_repo.dart';
import 'package:instafood/models/cart_model.dart';
import 'package:instafood/models/products_model.dart';
import 'package:instafood/models/user_model.dart';
import 'package:get/get.dart';

import '../pages/cart/cart_history.dart';

class CartController extends GetxController {
  CartRepo cartRepo;
  UsersData usersDataIns;
  CartController({required this.cartRepo, required this.usersDataIns});

  Map<int, CartModel> _items = {};

  int total = 0;
  // var cartHistorySourceData;

  Map<int, CartModel> get items => _items;
  List<CartModel> get getItems => _items.values.map((e) => e).toList();
  UserModel get getCurrentUserModel => usersDataIns.getCurrentUserModel ?? UserModel();
  set setItems(Map<int, CartModel> cartModel) => _items.addAll(cartModel);
  get usersData => usersDataIns.usersData;
  //
  int get totalCart {
    var totalItems = 0;
    _items.forEach((key, value) {
      totalItems += value.quantity!;
    });
    return totalItems;
  }

  int get totalAmount {
    var amount = 0;
    for (var element in getItems) {
      var itemAmount = element.price! * element.quantity!;
      amount += itemAmount;
    }
    return amount;
  }

  // List<CartModel> get getLocalCartHistoryStorage {
  //   setCartHistory = cartRepo.getCartHistory(getCurrentUserModel);
  //   return _historyStorage;
  // }

  /// (2) adding item.. from popular controller

  void cartItems(ProductModel productModel, int quantity) {
    update();
    var totalQuantity = 0;

    if (_items.containsKey(productModel.id)) {
      _items.update(productModel.id!, (value) {
        totalQuantity += value.quantity! + quantity;
        return CartModel(
          id: value.id,
          name: value.name,
          img: value.img,
          price: value.price,
          quantity: quantity,
          isExist: true,
          time: DateTime.now().toString(),
          productModel: productModel,
        );
      });

      if (totalQuantity <= 1) {
        _items.remove(productModel.id);
      }
    } else {
      _items.putIfAbsent(
          productModel.id!,
          () => CartModel(
                id: productModel.id,
                name: productModel.name,
                img: productModel.img,
                price: productModel.price,
                quantity: quantity,
                isExist: false,
                time: DateTime.now().toString(),
                productModel: productModel,
              ));
    }
    cartRepo.addToCartList(getItems, getCurrentUserModel);
    update();
  }

  bool existInCart(ProductModel productModel) {
    if (_items.containsKey(productModel.id)) {
      return true;
    } else {
      return false;
    }
  }

  int getQuantity(ProductModel productModel) {
    var quantity = 0;
    if (_items.containsKey(productModel.id)) {
      _items.forEach((key, value) {
        if (key == productModel.id) {
          quantity = value.quantity!;
        }
      });
    }
    return quantity;
  }

  // void addToCartHistory() {
  //   cartRepo.addToCartHistory(getCurrentUserModel);
  //   updateUserModelWithCartList();
  //   _clear();
  // }

  checkout() {
    Get.find<CartHistoryController>()
        .addToCartModelListPropertyCloud(cartRepo.getCartList(getCurrentUserModel));
    _clear();
  }

  /// clear data
  void clearItems() {
    _clear();
  }

  void _clear() {
    _items = {};
    cartRepo.clearCartListPreferences(getCurrentUserModel);

    update();
  }

  // clearHistoryListPreferences() {
  //   // _userItems = {};
  //   _currentUserCartHistoryAPI = [];
  //   cartRepo.clearHistoryListPreferences(getCurrentUserModel);
  //   update();
  // }

  // init cart history page
  // dataSource() {
  //   cartRepo.clearHistoryListPreferences(getCurrentUserModel);
  //   List<CartModel> cartList = getCurrentUserCartHistoryAPI.toList();
  //   cartRepo.addToCartListFromCloud(cartList, getCurrentUserModel);
  //   cartRepo.addToCartHistory(getCurrentUserModel);
  //   cartHistorySourceData = getLocalCartHistoryStorage.reversed.toList();
  //   update();
  // }
  //
  // timeOrderedItems() {
  //   orderedCartItemsByTime = {};
  //   try {
  //     for (var i = 0; i < cartHistorySourceData.length; i++) {
  //       if (orderedCartItemsByTime.containsKey(cartHistorySourceData[i].time)) {
  //         orderedCartItemsByTime.update(cartHistorySourceData[i].time, (value) => ++value);
  //       } else {
  //         orderedCartItemsByTime.putIfAbsent(cartHistorySourceData[i].time, () => 1);
  //       }
  //     }
  //     return orderedCartItemsByTime;
  //   } catch (e) {}
  //   update();
  // }
}
