import 'package:dio/dio.dart';

class ApiService {
  final Dio dio = Dio();

  Future<Response> post({
    required body,
    required String url,
    required String token,
    Map<String, String>? headers,
    String? contentType,
  }) async {
    Map<String, String> requestHeaders = {'Authorization': "Bearer $token"};

    if (headers != null) {
      requestHeaders.addAll(headers);
    }

    var response = await dio.post(
      url,
      data: body,
      options: Options(contentType: contentType, headers: requestHeaders),
    );

    return response;
  }
}
