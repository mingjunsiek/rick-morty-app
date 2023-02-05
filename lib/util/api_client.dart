import 'package:dio/dio.dart';

class ApiClient {
  late final Dio _client;

  void initialize() {
    _client = Dio();
    _client.options.baseUrl = 'https://rickandmortyapi.com';
  }

  Dio get client => _client;
}
