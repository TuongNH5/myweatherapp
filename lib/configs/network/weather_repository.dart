import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../screen/cubit/data_weather.dart';
import '../app_config.dart';
import '../injection.dart';

///Created by Nguyen Huu Tuong on 09/11/2023.
class WeatherRepository extends BaseRepository {
  Future<WeatherData> fetchWeatherData({required String city}) async {
    try {
      AppConfig appConfig = injector();
      final String url = appConfig.baseUrl ?? '';
      final Dio dio = Dio();
      final response = await dio.get(url + city);
      if (response.statusCode == 200) {
        final Map<String, dynamic> weatherData =  Map<String, dynamic>.from(
          response.data ?? 'No data',
        );
        final data = WeatherData.fromJson(weatherData);
        return data;
      } else {
        Fluttertoast.showToast(
            msg: "Please retype another city name!",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
        // Future.error('Failed to load weather data');
        throw Exception('Failed to fetch weather data');
      }
    } catch (e) {
      Fluttertoast.showToast(
          msg: "Please retype another city name!",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
      // Future.error('Failed to load weather data');
      throw Exception(e);
      // return WeatherData();
    }
  }
}

class BaseRepository {}
