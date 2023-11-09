
import 'package:get_it/get_it.dart';

import 'app_config.dart';
import 'network/weather_repository.dart';

final injector = GetIt.instance;
Future<void> initializeDependencies() async {
  injector.registerSingleton<AppConfig>(await AppConfig.production());

  injector.registerSingleton<WeatherRepository>(WeatherRepository());

}
