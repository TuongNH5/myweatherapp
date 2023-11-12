
import 'package:myweatherapp/configs/constants/api_constant.dart';
import 'package:myweatherapp/core/network/base_repository.dart';
import 'package:myweatherapp/data/source/network/data_weather.dart';

///Created by Nguyen Huu Tuong on 09/11/2023.
class WeatherRepository extends BaseRepository  {
  WeatherRepository() : super('');

  Future<DataWeather> fetchWeatherData({required String city}) async {
    print('start fetchWeatherData');
    return DataWeather.fromJson(await request(
        method: RequestMethod.get,
        path: city,
    ));
  }
}


