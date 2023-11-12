
import 'package:get_it/get_it.dart';
import 'package:myweatherapp/configs/app_navigator.dart';
import 'package:myweatherapp/core/network/network_manager.dart';

import 'app_config.dart';
import '../data/repositories/weather_repository.dart';
///Created by Nguyen Huu Tuong on 12/12/2023.

final injector = GetIt.instance;
Future<void> initializeDependencies() async {
  injector.registerSingleton<AppConfig>(await AppConfig.production());
  injector.registerSingleton<AppNavigator>(AppNavigator.instance);
  injector.registerLazySingleton<WeatherRepository>(WeatherRepository.new);
  injector.registerSingleton<NetworkManager>(NetworkManager());

}
