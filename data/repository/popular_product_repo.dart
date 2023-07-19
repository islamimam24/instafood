import 'package:instafood/data/api/api_client.dart';
import 'package:instafood/utils/app_constant.dart';
import 'package:get/get.dart';

class PopularProductRepo extends GetxService {
  final APIClient apiClient; // instance so i can access APIClient
  PopularProductRepo({required this.apiClient});

  Future<Response> getPopularProductList() async {
    return await apiClient.getData(AppConstant.REST_POPULAR_PRODUCTS);
  }
}
