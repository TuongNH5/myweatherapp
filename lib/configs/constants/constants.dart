import 'package:flutter/material.dart';

class Constants {
  static const primaryColor = Color(0xff6b9dfc);
  static const secondaryColor = Color(0xffa1c6fd);
  static const tertiaryColor = Color(0xff205cf1);
  static const blackColor = Color(0xff1a1d26);

  static const greyColor = Color(0xffd9dadb);

  static final Shader shader = const LinearGradient(
    colors: <Color>[Color(0xffABCFF2), Color(0xff9AC6F3)],
  ).createShader(const Rect.fromLTWH(0.0, 0.0, 200.0, 70.0));

  static const linearGradientBlue = LinearGradient(
      begin: Alignment.bottomRight,
      end: Alignment.topLeft,
      colors: [Color(0xff6b9dfc), Color(0xff205cf1)],
      stops: [0.0, 1.0]);
  static const linearGradientPurple = LinearGradient(
      begin: Alignment.bottomRight,
      end: Alignment.topLeft,
      colors: [Color(0xff51087E), Color(0xff6C0BA9)],
      stops: [0.0, 1.0]);

  static String pathIconWeather() {
    DateTime now = DateTime.now();
    int currentHour = now.hour;
    var icon = 'assets/clear.png';
    if (currentHour >= 12 && currentHour < 18) {
      icon = 'assets/sunny.png';
    } else if (currentHour >= 18 || currentHour < 6) {
      icon = 'assets/overcast.png';
    }
    return icon;
  }

  static List<Color> setBackgroundColorWeather() {
    DateTime now = DateTime.now();
    int currentHour = now.hour;
    var bgColor = [
      const Color(0xFF9CECFB),
      const Color(0xFF65C7F7), // #65C7F7
      const Color(0xFF5896F6), // #0052D4
    ];
    if (currentHour >= 12 && currentHour < 18) {
      bgColor = [
        Color(0xFFF5AF19), // #f5af19
        Color(0xFFFF5A4C),
      ];
    } else if (currentHour >= 18 || currentHour < 6) {
      bgColor = [
        Color(0xFF434343), // #434343
        Color(0xFF000000),
      ];
    }
    return bgColor;
  }
}
