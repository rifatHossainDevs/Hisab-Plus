part of 'network_caller.dart';

class NetworkResponse {
  final bool isSuccess;
  final int statusCode;
  final String? errorMessage;
  final dynamic body;

  NetworkResponse({
    required this.isSuccess,
    required this.statusCode,
    this.errorMessage,
    this.body,
  });
}