import 'package:intl/intl.dart';

class WeatherData {
  final String? location;
  final String? currentDate;
  final String? currentWeatherStatus;
  final  String? weatherIcon;
  final  int? temperature;
  final  int? windSpeed;
  final int? humidity;
  final int? cloud;
  final List<HourlyForecast>? hourlyWeatherForecast;
  final List<DailyForecast>? dailyWeatherForecast;

  WeatherData({
     this.location,
     this.currentDate,
     this.currentWeatherStatus,
     this.weatherIcon,
     this.temperature,
     this.windSpeed,
     this.humidity,
     this.cloud,
     this.hourlyWeatherForecast,
     this.dailyWeatherForecast,
  });
   String getShortLocationName(String s) {
    List<String> wordList = s.split(" ");

    if (wordList.isNotEmpty) {
      if (wordList.length > 1) {
        return wordList[0] + " " + wordList[1];
      } else {
        return wordList[0];
      }
    } else {
      return " ";
    }
  }
  factory WeatherData.fromJson(Map<String, dynamic> json) {
    final locationData = json["location"];
    final currentWeather = json["current"];

    final parsedHourlyForecast = (json["forecast"]["forecastday"][0]["hour"] as List)
        .map((hourlyData) => HourlyForecast.fromJson(hourlyData))
        .toList();

    final parsedDailyForecast = (json["forecast"]["forecastday"] as List)
        .map((dailyData) => DailyForecast.fromJson(dailyData))
        .toList();

    final locationName = locationData["name"];
    final currentDate = DateFormat('MMMMEEEEd').format(
        DateTime.parse(locationData["localtime"].substring(0, 10)));
    final currentWeatherStatus = currentWeather["condition"]["text"];
    final weatherIcon = currentWeatherStatus.replaceAll(' ', '').toLowerCase() + ".png";
    final temperature = currentWeather["temp_c"].toInt();
    final windSpeed = currentWeather["wind_kph"].toInt();
    final humidity = currentWeather["humidity"].toInt();
    final cloud = currentWeather["cloud"].toInt();

    return WeatherData(
      location: locationName,
      currentDate: currentDate,
      currentWeatherStatus: currentWeatherStatus,
      weatherIcon: weatherIcon,
      temperature: temperature,
      windSpeed: windSpeed,
      humidity: humidity,
      cloud: cloud,
      hourlyWeatherForecast: parsedHourlyForecast,
      dailyWeatherForecast: parsedDailyForecast,
    );
  }
  // Map<String, dynamic> toJson() {
  //   final Map<String, dynamic> data = {
  //     "location": {"name": location},
  //     "current": {
  //       "condition": {"text": currentWeatherStatus},
  //       "temp_c": temperature,
  //       "wind_kph": windSpeed,
  //       "humidity": humidity,
  //       "cloud": cloud,
  //     },
  //     "forecast": {
  //       "forecastday": dailyWeatherForecast.map((dailyData) => dailyData.toJson()).toList(),
  //     },
  //   };
  //
  //   return data;
  // }
}

class HourlyForecast {
  String time;
  int temperature;
  int windSpeed;

  HourlyForecast({
    required this.time,
    required this.temperature,
    required this.windSpeed,
  });

  factory HourlyForecast.fromJson(Map<String, dynamic> json) {
    return HourlyForecast(
      time: json["time"],
      temperature: json["temp_c"].toInt(),
      windSpeed: json["wind_kph"].toInt(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "time": time,
      "temp_c": temperature,
      "wind_kph": windSpeed,
    };
  }
}

class DailyForecast {
  String date;
  String currentWeatherStatus;
  int maxTemperature;
  int minTemperature;

  DailyForecast({
    required this.date,
    required this.currentWeatherStatus,
    required this.maxTemperature,
    required this.minTemperature,
  });

  factory DailyForecast.fromJson(Map<String, dynamic> json) {
    return DailyForecast(
      date: json["date"],
      currentWeatherStatus: json["day"]["condition"]["text"],
      maxTemperature: json["day"]["maxtemp_c"].toInt(),
      minTemperature: json["day"]["mintemp_c"].toInt(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "date": date,
      "day": {
        "condition": {"text": currentWeatherStatus},
        "maxtemp_c": maxTemperature,
        "mintemp_c": minTemperature,
      },
    };
  }
}
