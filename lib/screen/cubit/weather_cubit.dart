import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import '../../configs/injection.dart';
import '../../configs/network/weather_repository.dart';
import 'data_weather.dart';
part 'weather_success_state.dart';
class WeatherCubit extends Cubit<WeatherSuccessState> {
  WeatherCubit() : super(const WeatherSuccessState());
  WeatherRepository weatherRepository = injector();

  void fetchApiGetWeather({required String city}) async {
    final weatherData = await weatherRepository.fetchWeatherData(city: city);
    emit(state.copyWith(weatherData: weatherData));
  }
}
