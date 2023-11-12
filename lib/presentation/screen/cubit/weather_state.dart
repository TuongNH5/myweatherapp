part of 'weather_cubit.dart';


class WeatherState extends Equatable {
  final DataWeather? dataWeather;


  @override
  // TODO: implement props
  List<Object?> get props => [
    dataWeather,
  ];

//<editor-fold desc="Data Methods">
  const WeatherState({
    this.dataWeather,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is WeatherState && runtimeType == other.runtimeType && dataWeather == other.dataWeather);

  @override
  int get hashCode => dataWeather.hashCode;

  @override
  String toString() {
    return 'WeatherState{' + ' weatherData: $dataWeather,' + '}';
  }

  WeatherState copyWith({
    DataWeather? dataWeather,
  }) {
    return WeatherState(
      dataWeather: dataWeather ?? this.dataWeather,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'weatherData': this.dataWeather,
    };
  }

  factory WeatherState.fromMap(Map<String, dynamic> map) {
    return WeatherState(
      dataWeather: map['weatherData'] as DataWeather,
    );
  }

//</editor-fold>
}
