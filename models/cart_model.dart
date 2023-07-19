import 'package:instafood/models/products_model.dart';

import 'user_model.dart';

class CartModel {
  int? _id;
  String? _name;
  int? _price;
  String? _img;
  int? _quantity;
  bool? _isExist;
  late ProductModel _productModel;
  String? _time;

  // late UserModel _userModel;

  String? get name => _name;
  String? get img => _img;
  int? get id => _id;
  int? get price => _price;
  int? get quantity => _quantity;
  bool? get isExist => _isExist;
  ProductModel get productModel => _productModel;
  String? get time => _time;
  set setTime(String time) {
    _time = time;
  }

  // UserModel get userModel => _userModel;

  CartModel(
      {int? id,
      String? name,
      int? price,
      String? img,
      int? quantity,
      bool? isExist,
      required ProductModel productModel,
      String? time}) {
    _img = img;
    _price = price;
    _name = name;
    _id = id;
    _quantity = quantity;
    _isExist = isExist;
    _productModel = productModel;
    _time = time;
  }

  CartModel.fromJson(Map<String, dynamic> json) {
    _id = json['id'];
    _name = json['name'];
    _price = json['price'];
    _img = json['img'];
    _quantity = json['quantity'];
    _productModel = ProductModel.fromJson(json["productModel"]);
    _time = json["time"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = _id;
    data['name'] = _name;
    data['price'] = _price;
    data['img'] = _img;
    data['quantity'] = _quantity;
    data['productModel'] = _productModel;
    data['time'] = _time;

    return data;
  }
}
