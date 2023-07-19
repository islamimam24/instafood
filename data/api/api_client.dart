import 'package:instafood/utils/app_constant.dart';
import 'package:get/get.dart';

class APIClient extends GetConnect /*implements GetxService*/ {
  // getxServices is instead of http.client
  String token = AppConstant.TOKEN;
  final String appBaseUrl;
  late Map<String, String> _mainHeaders;

  APIClient({required this.appBaseUrl}) {
    // baseUrl is a GetConnect variable you should save your base Url to it
    baseUrl = appBaseUrl;
    // timeout = const Duration(seconds: 30);
    _mainHeaders = {
      "content-type": 'application/json; charset=UTF-8',
      'Authorization': 'bearer $token', // Authentication type = bearer
    };
  }

  Future<Response> getData(String uri) async {
    try {
      //get() doesnt want the complete Url, t just needs the nd point
      Response response = await get(uri);
      return response;
    } catch (e) {
      return Response();
    }
  }

  Future<Response> setData(String uri, Map<String, dynamic> map) async {
    try {
      Response response = await patch(uri, map, contentType: "application/json");
      return response;
    } catch (e) {
      print(e);
    }
    return Response();
  }

  // Future<Response> updateData(String uri, value) async {
  //   try {
  //     Response response = await put(uri, value);
  //     return response;
  //   } catch (e) {
  //     print(e);
  //   }
  //   return Response();
  // }
}
