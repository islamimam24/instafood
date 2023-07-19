import 'package:instafood/controllers/cart_controller.dart';
import 'package:instafood/data/repository/popular_product_repo.dart';
import 'package:instafood/models/user_model.dart';
import 'package:get/get.dart';
import '../models/products_model.dart';

class PopularProductController extends GetxController {
  // getting data from API
  final PopularProductRepo popularProductRepo;

  //creating a list of productModel
  List<ProductModel> _popularProductList = [];

  List<ProductModel> get popularProductList => _popularProductList;

  CartController _cartController;

  PopularProductController({
    required this.popularProductRepo,
    required CartController cartController,
  }) : _cartController = cartController;

// dealing with items
  int _quantity = 0;
  int _inCartItems = 0;
  bool? _isExist = false;

  int get quantity => _quantity;

  int get totalQuantity => _inCartItems + _quantity;

  bool? get isExist => _isExist;

  int get totalItems => _cartController.totalCart;

  Future<void> getPopularProductList() async {
    Response response = await popularProductRepo.getPopularProductList();
    if (response.statusCode == 200) {
      _popularProductList = [];
      _popularProductList
          .addAll(Product.fromJson(response.body).products as Iterable<ProductModel>);
      update();
    }
  }

  void setQuantity(bool isIncrease) {
    if (isIncrease) {
      _quantity = checkQuantity(_quantity + 1);
    } else {
      _quantity = checkQuantity(_quantity - 1);
    }

    // to run update method you have to hotReload the app or wrap whatever widget you will use this function at, with GetBuilder()
    update();
    // print(_inCartItems);
    // print(quantity);
  }

  int checkQuantity(int quantity) {
    if ((quantity + _inCartItems <= 20 && quantity + _inCartItems >= 0)) {
      return quantity;
    }
    if (quantity + _inCartItems > 20) {
      Get.snackbar("warning!", "20 is the maximum value");
      return 20;
    } else if (quantity + _inCartItems < 0) {
      Get.snackbar("warning!", "0 is the minimum value");
      quantity = 0;
      _inCartItems = 0;
      return 0;
    }
    return 00;
  }

  void initPage(ProductModel productModel, CartController cart) {
    _quantity = 0;
    _inCartItems = 0;
    _cartController = cart;
    _isExist = cart.existInCart(productModel);
    if (_isExist == true) {
      _inCartItems = cart.getQuantity(productModel);
    }
  }

  /// (1) adding item
  void addItem(ProductModel productModel) {
    if (totalQuantity > 0) {
      _cartController.cartItems(productModel, totalQuantity);
    } else {
      Get.snackbar('Item Count', "you must Add up an item");
    }
    update();
  }
}
