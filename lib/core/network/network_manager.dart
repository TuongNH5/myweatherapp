
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import '../../configs/app_config.dart';
import '../../configs/injection.dart';
///Created by Nguyen Huu Tuong on 12/12/2023.

class NetworkManager {
  NetworkManager() {
    initDio();
  }
  Dio? _dio;
  Dio? _refreshTokenDio;
  static const int connectTimeout = 60000;
  static const int receiveTimeout = 60000;
  String _baseUrl = '';
  void initDio() {
    _baseUrl = injector<AppConfig>().baseUrl ?? '';
    final options = BaseOptions(
        baseUrl: _baseUrl,
        connectTimeout: const Duration(milliseconds: connectTimeout),
        receiveTimeout: const Duration(milliseconds: receiveTimeout),
        headers: {'Accept': 'application/json'},
        validateStatus: (_) => true);
    _dio = Dio(options);
    _refreshTokenDio?.options = _dio?.options ?? options;
    _refreshTokenDio = Dio(options);
  }


  Future<Map<String, dynamic>?> request(String method, String path,
      {Map<String, dynamic>? queryParameters,
      Map<String, dynamic>? data,
      Map<String, dynamic>? headers,
      bool isLoadFromCache = true,
      Map<String, dynamic>? extra}) async {

    print(_dio?.options.headers);
    log('queryParameters: $queryParameters');
    log('dataOutput: -> $data');
    log('headers: $headers');
    log('extra: $extra');
    try {
      final result = await _dio?.request(path,
          queryParameters: queryParameters ?? <String, dynamic>{},
          options: Options(method: method, headers: headers, extra: extra),
          data: data,
          cancelToken: CancelToken());
      print('result NetworkManager ${result.toString()}');
      return result?.data as Map<String, dynamic>?;
    } catch (error) {
      print('error NetworkManager $error');
      return null;
    }
  }


}
