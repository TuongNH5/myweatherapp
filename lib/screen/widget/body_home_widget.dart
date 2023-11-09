import 'package:flutter/cupertino.dart';
import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:ui';
import 'package:flutter/services.dart';
import 'package:myweatherapp/screen/widget/weather_item.dart';

import '../../configs/constants/constants.dart';
import '../cubit/weather_cubit.dart';

class BodyHomeWidget extends StatelessWidget {
  const BodyHomeWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WeatherCubit, WeatherSuccessState>(
      builder: (context, state) {
        final data = state.weatherData;
        if (data?.currentDate?.isNotEmpty == true) {
          print('data ${data?.currentDate}');
        }
        return Container(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Image.asset(
                    "assets/pin.png",
                    width: 20,
                  ),
                  const SizedBox(
                    width: 2,
                  ),
                  Text(
                    data?.location ?? '',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16.0,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 160,
                child: Image.asset(Constants.pathIconWeather()),
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Text(
                      (data?.temperature ?? 0).toString(),
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 80,
                        fontWeight: FontWeight.bold,
                        // foreground: Paint()..shader = AppColors.shader,
                      ),
                    ),
                  ),
                  const Text(
                    'o',
                    style: TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,

                      // foreground: Paint()..shader = AppColors.shader,
                    ),
                  ),
                ],
              ),
              Text(
                data?.currentWeatherStatus ?? '',
                style: const TextStyle(
                  color: Colors.white70,
                  fontSize: 20.0,
                ),
              ),
              Text(
                data?.currentDate ?? '',
                style: const TextStyle(
                  color: Colors.white70,
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: const Divider(
                  color: Colors.white70,
                ),
              ),
              Container(
                decoration: ShapeDecoration(
                  gradient: LinearGradient(
                    begin: Alignment(-1.00, -0.04),
                    end: Alignment(1, 0.04),
                    colors: [Colors.white.withOpacity(0.23999999463558197), Colors.white.withOpacity(0.07999999821186066)],
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 40),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    WeatherItem(
                      value: (data?.windSpeed ?? 0).toInt(),
                      unit: 'km/h',
                      imageUrl: 'assets/windspeed.png',
                    ),
                    WeatherItem(
                      value: (data?.humidity ?? 0).toInt(),
                      unit: '%',
                      imageUrl: 'assets/humidity.png',
                    ),
                    WeatherItem(
                      value: (data?.cloud ?? 0).toInt(),
                      unit: '%',
                      imageUrl: 'assets/cloud.png',
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );

  }
}
