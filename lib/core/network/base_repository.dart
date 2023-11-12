
import 'package:flutter/foundation.dart';
import 'package:myweatherapp/data/source/network/models/base_input.dart';
import '../../configs/injection.dart';
import 'network_manager.dart';
///Created by Nguyen Huu Tuong on 12/12/2023.

abstract class BaseRepository {
  final String _serviceName;
  NetworkManager? _networkManager;

  BaseRepository(this._serviceName) {
    _networkManager = injector();
  }
  Future<Map<String, dynamic>?> request<DataType, QueryType>(
      {required String method,
      required String path,
      QueryType? queryParameters,
      DataType? data,
      Map<String, dynamic>? headers,
      Map<String, dynamic>? extra,
      bool isNotLoadCacheFail = true}) async {
    print('start request BaseRepository ');
    final result = await _networkManager?.request(
        method.toUpperCase(), '$_serviceName$path',
        queryParameters: (queryParameters is BaseInput)
            ? queryParameters.toJson()
            : (queryParameters as Map<String, dynamic>?),
        data: (data is BaseInput)
            ? data.toJson()
            : (data as Map<String, dynamic>?),
        isLoadFromCache: isNotLoadCacheFail,
        headers: headers,
        extra: extra);

    if (kDebugMode) {
      print('result BaseRepository ${result.toString()}');
      // logger.d(result);
    }
    return result;
  }

}
