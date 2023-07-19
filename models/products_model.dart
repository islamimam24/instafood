class Product {
  int? _totalSize;
  int? _typeId;
  int? _offset;
  List<ProductModel>? _products;

  List<ProductModel>? get products => _products;

  Product({required totalSize, required typeId, required offset, required products}) {
    _totalSize = totalSize;
    _typeId = typeId;
    _offset = offset;
    _products = products;
  }

  Product.fromJson(Map<String, dynamic> json) {
    _totalSize = json['total_size'];
    _typeId = json['type_id'];
    _offset = json['offset'];
    if (json['products'] != null) {
      _products = <ProductModel>[];
      json['products'].forEach((value) {
        _products!.add(ProductModel.fromJson(value));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['total_size'] = _totalSize;
    data['type_id'] = _typeId;
    data['offset'] = _offset;
    if (_products != null) {
      data['products'] = _products!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ProductModel {
  int? _id;
  String? _name;
  String? _description;
  int? _price;
  int? _stars;
  String? _img;
  String? _location;
  String? _createdAt;
  String? _updatedAt;
  int? _typeId;

  String? get name => _name;
  String? get img => _img;
  int? get id => _id;
  String? get description => _description;
  int? get price => _price;

  ProductModel(
      {int? id,
      String? name,
      String? description,
      int? price,
      int? stars,
      String? img,
      String? location,
      String? createdAt,
      String? updatedAt,
      int? typeId,
      int? quantity,
      bool isfav = false})
      : _typeId = typeId,
        _updatedAt = updatedAt,
        _createdAt = createdAt,
        _location = location,
        _img = img,
        _stars = stars,
        _price = price,
        _description = description,
        _name = name,
        _id = id;

  ProductModel.fromJson(Map<String, dynamic> json) {
    _id = json['id'];
    _name = json['name'];
    _description = json['description'];
    _price = json['price'];
    _stars = json['stars'];
    _img = json['img'];
    _location = json['location'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
    _typeId = json['type_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = _id;
    data['name'] = _name;
    data['description'] = _description;
    data['price'] = _price;
    data['stars'] = _stars;
    data['img'] = _img;
    data['location'] = _location;
    data['created_at'] = _createdAt;
    data['updated_at'] = _updatedAt;
    data['type_id'] = _typeId;
    return data;
  }
}
