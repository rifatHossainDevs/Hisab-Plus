
import 'dart:convert';

import 'package:http/http.dart';
import 'package:logger/logger.dart';

part 'network_response.dart';

class NetworkCaller {
  final Logger _logger = Logger();

  final Map<String, String> Function() headers;

  NetworkCaller({required this.headers});

  Future<NetworkResponse> getRequest(String url) async {
    try {
      Uri uri = Uri.parse(url);
      _logRequest(url);

      Response response = await get(uri, headers: headers());

      final decodedJson = jsonDecode(response.body);

      if (response.statusCode == 200) {
        _logResponse(response);
        return NetworkResponse(
          isSuccess: true,
          statusCode: response.statusCode,
          body: decodedJson,
        );
      } else if (response.statusCode == 401) {
        _logResponse(response, isError: true);
        return NetworkResponse(
          isSuccess: false,
          statusCode: response.statusCode,
          errorMessage: decodedJson['message']?.toString().trim() ?? 'Unauthorized',
        );
      } else {
        _logResponse(response, isError: true);
        return NetworkResponse(
          isSuccess: false,
          statusCode: response.statusCode,
          errorMessage: decodedJson['message']?.toString().trim() ??
              'Something went wrong',
        );
      }
    } catch (e) {
      _logger.e('''URL=> $url
      message => ${e.toString()}''');
      return NetworkResponse(
        isSuccess: false,
        statusCode: -1,
        errorMessage: e.toString(),
      );
    }
  }

  void _logRequest(String url, {Map<String, dynamic>? body}) {
    _logger.i('''Request URL: $url
    Request Body: $body''');
  }

  void _logResponse(Response response, {bool isError = false}) {
    if (isError) {
      _logger.e('''URL=> ${response.request!.url}
      Header => ${response.headers}
      Response Status Code => ${response.statusCode}
      Response Body => ${response.body}''');
    } else {
      _logger.i('''URL=> ${response.request!.url}
      Header => ${response.headers}
      Response Status Code => ${response.statusCode}
      Response Body => ${response.body}''');
    }
  }
}
