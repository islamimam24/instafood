import 'package:instafood/data/api/api_client.dart';
import 'package:get/get.dart';
import 'package:instafood/utils/app_constant.dart';

class RecommendedProductRepo extends GetxService {
  final APIClient apiClient;

  RecommendedProductRepo({required this.apiClient});

  Future<Response> recommendedProductList() async {
    return await apiClient.getData(AppConstant.REST_RECOMMENDED_PRODUCTS);
  }

  Future<Response> getUsersData() async {
    return await apiClient.getData(AppConstant.REST_USERS);
  }
}
