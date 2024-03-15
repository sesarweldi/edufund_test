import 'package:dio/dio.dart';
import 'package:edufund_test/data/constant/api_constant.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class ApiClient {
  final Dio _dio = Dio();

  ApiClient() {
    _dio.options = BaseOptions(
      sendTimeout: const Duration(seconds: 3),
      connectTimeout: const Duration(seconds: 5),
      receiveTimeout: const Duration(seconds: 10),
      baseUrl: ApiConstant.baseUrl,
    );
    _dio.interceptors.add(PrettyDioLogger());
  }

  Dio get sendRequest => _dio;
}
