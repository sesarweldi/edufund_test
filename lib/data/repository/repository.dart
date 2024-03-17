import 'package:dio/dio.dart';
import 'package:edufund_test/data/constant/api_constant.dart';
import 'package:edufund_test/data/network/api_client.dart';
import 'package:edufund_test/model/testimonial.dart';

class Repository {
  ApiClient api = ApiClient();

  Future<List<Testimonial>> getTestimonials(int? page, String? search) async {
    final Map<String, dynamic> queryParams = {};

    queryParams['page'] = page;
    queryParams['limit'] = ApiConstant.limit;
    queryParams['search'] = search;
    try {
      Response response =
          await api.sendRequest.get("", queryParameters: queryParams);
      return (response.data as List<dynamic>).map((item) => Testimonial.fromJson(item)).toList();
    } catch (ex) {
      rethrow;
    }
  }
}
