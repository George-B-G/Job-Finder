import 'package:dio/dio.dart';

class DioHelper {
  static Dio? dio; // object from dio
  static init() {
    // starting state dio
    dio = Dio(BaseOptions(
      baseUrl: 'https://project2.amit-learning.com/',
      receiveDataWhenStatusError: true, // to tell if error happens
    ));
  }

  static Future<Response> getData({
    required String url,
    required Map<String, dynamic> query,
    required Map<String, dynamic> headers,
  }) async {
    return await dio!
        .get(url, queryParameters: query, options: Options(headers: headers));
  }

  static Future<Response> postData({
    required String url,
    required Map<String, dynamic> query,
    required Map<String, dynamic> headers,
  }) async {
    return await dio!
        .post(url, queryParameters: query, options: Options(headers: headers));
  }
}
