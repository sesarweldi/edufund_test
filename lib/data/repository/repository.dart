import 'package:dio/dio.dart';
import 'package:edufund_test/data/network/api_client.dart';
import 'package:edufund_test/model/testimonial.dart';

class Repository {
  ApiClient api = ApiClient();

  Future<List<Testimonial>> getTestimonials(
      int? page, int? limit, String? search) async {
    final Map<String, dynamic> queryParams = {};

    queryParams['page'] = page;
    queryParams['limit'] = limit;
    queryParams['search'] = search;
    try {
      Response response =
          await api.sendRequest.get("", queryParameters: queryParams);
      return response.data;
    } catch (ex) {
      rethrow;
    }
  }
}
