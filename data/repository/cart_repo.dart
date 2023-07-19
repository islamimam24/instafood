import 'dart:convert';

import 'package:instafood/models/cart_model.dart';
import 'package:instafood/models/user_model.dart';
import 'package:instafood/utils/app_constant.dart';
import 'package:get/get_connect/http/src/response/response.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../api/api_client.dart';

class CartRepo {
  late SharedPreferences sharedPreferences;
  APIClient apiClient;

  CartRepo({required this.sharedPreferences, required this.apiClient});

  List<String> cartList = [];
  List<String> cartHistory = [];

  void setData(Map<String, dynamic> json) async {
    try {
      // await apiClient.setUserData("${AppConstant.REST_USERS}/${userModel.email}", map);
      await apiClient.setData(AppConstant.REST_USERS, json);
    } on Exception catch (e) {
      print("auth Error: $e");
    }
  }

  Future<Response> getData() async {
    return await apiClient.getData(AppConstant.REST_USERS);
  }

  /// CART LIST
  void addToCartList(List<CartModel> items, UserModel userModel) {
    cartList = [];
    String cartListSharedPreferenceKEY = "${userModel.email.toString()}/${AppConstant.cart_list}";

    String time = DateTime.now().toString();
    // json  encode access toJson() automatically ==> takes object converts it to json as a string
    items.forEach((element) {
      element.setTime = time;
      cartList.add(jsonEncode(element));
    });
    // shared preferences only takes list of strings
    sharedPreferences.setStringList(cartListSharedPreferenceKEY, cartList);
    // print("(1)cartList: $cartList");

    // getCartList(userModel);
  }

  void addToCartListFromCloud(List<CartModel> items, UserModel userModel) {
    cartList = [];
    String cartListSharedPreferenceKEY = "${userModel.email.toString()}/${AppConstant.cart_list}";
    items.forEach((element) {
      cartList.add(jsonEncode(element));
    });
    sharedPreferences.setStringList(cartListSharedPreferenceKEY, cartList);
  }

  List<CartModel> getCartList(UserModel userModel) {
    List<CartModel> cartModelList = [];

    String cartListSharedPreferenceKEY = "${userModel.email.toString()}/${AppConstant.cart_list}";
    // getting cart list as an object so i can access its properties
    // json  decode access fromJson() automatically ==> takes jsonString converts it to json as an object
    if (sharedPreferences.containsKey(cartListSharedPreferenceKEY)) {
      try {
        sharedPreferences
            .getStringList(cartListSharedPreferenceKEY)
            ?.forEach((element) => cartModelList.add(CartModel.fromJson(jsonDecode(element))));
      } on Exception catch (e) {
        print(e);
      }
    }
    print("(2)getCartList: $cartModelList");
    return cartModelList;
  }

  /// CART HISTORY
  // void addToCartHistory(UserModel userModel) {
  //   String sharedPreferenceKEY = "${userModel.email.toString()}/${AppConstant.cart_list_history}";
  //
  //   if (sharedPreferences.containsKey(sharedPreferenceKEY)) {
  //     sharedPreferences.getStringList(sharedPreferenceKEY);
  //   }
  //   for (var element in cartList) {
  //     cartHistory.add(element);
  //   }
  //   sharedPreferences.setStringList(sharedPreferenceKEY, cartHistory);
  //   // print("(3)add to cart history : $cartHistory");
  // }
  //
  // List<CartModel> getCartHistory(UserModel userModel) {
  //   String sharedPreferenceKEY = "${userModel.email.toString()}/${AppConstant.cart_list_history}";
  //
  //   List<CartModel> cartHistoryList = [];
  //
  //   if (sharedPreferences.containsKey(sharedPreferenceKEY)) {
  //     try {
  //       cartHistory = sharedPreferences.getStringList(sharedPreferenceKEY)!;
  //       for (var element in cartHistory) {
  //         cartHistoryList.add(CartModel.fromJson(jsonDecode(element)));
  //       }
  //     } on Exception catch (e) {
  //       print(e);
  //     }
  //   }
  //   // print("(4) get cart history List $cartHistoryList");
  //   return cartHistoryList;
  // }

  void clearCartListPreferences(UserModel userModel) {
    cartList = [];
    sharedPreferences.remove("${userModel.email.toString()}/${AppConstant.cart_list}");
  }

  // clearHistoryListPreferences(UserModel userModel) {
  //   cartList = [];
  //   cartHistory = [];
  //   sharedPreferences.remove("${userModel.email.toString()}/${AppConstant.cart_list}");
  //   sharedPreferences.remove("${userModel.email.toString()}/${AppConstant.cart_list_history}");
  // }
}
