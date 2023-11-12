import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:myweatherapp/configs/injection.dart';
import 'package:myweatherapp/data/repositories/weather_repository.dart';
import 'package:myweatherapp/core/bloc/bloc_widget/widget_cubit.dart';

import '../../../data/source/network/data_weather.dart';
part 'weather_state.dart';
class WeatherCubit extends WidgetCubit<WeatherState> {
  WeatherCubit() : super(widgetState: const WeatherState());
  WeatherRepository weatherRepository = injector();

  void fetchApiGetWeather({required String city}) async {
    print('start fetchApiGetWeather WeatherCubit');
    final dynamic output = await fetchApi(() => weatherRepository.fetchWeatherData(city: city),
      showLoading: true,);
    print('output: ${output.toString()}');
    if (output is DataWeather) {
      emit(state.copyWith(dataWeather: output)  );
    }

    }

  @override
  void onWidgetCreated() {
    // TODO: implement onWidgetCreated
  }
}
