import 'package:instafood/models/cart_model.dart';
import 'package:instafood/models/products_model.dart';

class UserModel {
  String? _name, _email, _password, _photoURL;
  int? _phone;
  List<CartModel>? _cartModelList;
  bool _isGoogleUser = false;
  List<ProductModel>? favProductList = [];

  String? get name => _name;
  String? get email => _email;
  String? get password => _password;
  int? get phone => _phone;
  String? get photoURL => _photoURL;
  List<CartModel>? get cartModelList => _cartModelList;
  bool get isGoogleUser => _isGoogleUser;

  set name(String? name) => _name = name;
  set email(String? email) => _email = email;
  set password(String? password) => _password = password;
  set phone(int? phone) => _phone = phone;
  set photoURL(String? photoURL) => _photoURL = photoURL;
  set cartModelList(List<CartModel>? cart) => _cartModelList = cart;
  set setGoogleUser(bool isGoogleUser) => _isGoogleUser = isGoogleUser;

  UserModel({name, email, password, phone, cartModelList, photoURL, isGoogleUser = false, favProductList}) {
    _name = name;
    _email = email;
    _password = password;
    _phone = phone;
    _cartModelList = cartModelList;
    _photoURL = photoURL;
    _isGoogleUser = isGoogleUser;
    favProductList = favProductList;
  }

  UserModel.fromJson(Map<String, dynamic> json) {
    _name = json["name"];
    _email = json["email"];
    _password = json["password"];
    _phone = json["phone"];
    _photoURL = json["photoURL"];
    _isGoogleUser = json["isGoogleUser"];
    _cartModelList = json["cartModelList"] != null ? getCartModelList(json["cartModelList"]) : [];
    favProductList = json["cartModelList"] != null ? getFavProductList(json["favProductList"]) : [];
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = {};
    data['email'] = _email;
    data['password'] = _password;
    data['name'] = _name;
    data['phone'] = _phone;
    data['photoURL'] = _photoURL;
    data['isGoogleUser'] = _isGoogleUser;
    data['cartModelList'] = _cartModelList;
    data["favProductList"] = favProductList;
    return data;
  }

  List<CartModel> getCartModelList(List<dynamic> value) {
    List<CartModel> cartModelList = [];
    value.forEach((element) {
      if (element.runtimeType == CartModel) {
        cartModelList.add(element);
      } else {
        cartModelList.add(CartModel.fromJson(element));
      }
    });
    return cartModelList;
  }

  List<ProductModel> getFavProductList(value) {
    List<ProductModel> productModelList = [];
    if (value.isNotEmpty) {
      value.forEach((element) {
        if (element.runtimeType == ProductModel) {
          productModelList.add(element);
        } else {
          productModelList.add(ProductModel.fromJson(element));
        }
      });
    }
    return productModelList;
  }
}
