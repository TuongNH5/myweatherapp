part of 'weather_cubit.dart';


class WeatherSuccessState extends Equatable {
  final WeatherData? weatherData;


  @override
  // TODO: implement props
  List<Object?> get props => [
    weatherData,
  ];

//<editor-fold desc="Data Methods">
  const WeatherSuccessState({
    this.weatherData,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is WeatherSuccessState && runtimeType == other.runtimeType && weatherData == other.weatherData);

  @override
  int get hashCode => weatherData.hashCode;

  @override
  String toString() {
    return 'WeatherState{' + ' weatherData: $weatherData,' + '}';
  }

  WeatherSuccessState copyWith({
    WeatherData? weatherData,
  }) {
    return WeatherSuccessState(
      weatherData: weatherData ?? this.weatherData,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'weatherData': this.weatherData,
    };
  }

  factory WeatherSuccessState.fromMap(Map<String, dynamic> map) {
    return WeatherSuccessState(
      weatherData: map['weatherData'] as WeatherData,
    );
  }

//</editor-fold>
}
