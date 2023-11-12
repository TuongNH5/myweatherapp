import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'dart:ui';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:myweatherapp/configs/auto_router/app_router.dart';
import 'package:myweatherapp/configs/constants/values/colors.dart';
import 'package:myweatherapp/configs/constants/values/dimens.dart';
import '../../../data/source/network/data_weather.dart';
import '../cubit/weather_cubit.dart';

class FooterWidget extends StatelessWidget {
  const FooterWidget({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return BlocBuilder<WeatherCubit, WeatherState>(
      builder: (context, state) {
        final data = state.dataWeather;
        return Container(
          padding: const EdgeInsets.only(top: 10),
          height: size.height * .20,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap: () {},
                    child: const Text(
                      'Today',
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0, color: Colors.white),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      context.pushRoute(DetailRoute(
                        list: data?.dailyWeatherForecast,
                      ));
                    }, //this will open forecast screen
                    child: const Text(
                      'Forecasts',
                      style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16, color: Colors.white),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 8,
              ),
              data?.hourlyWeatherForecast?.isNotEmpty == true ? ListViewHourlyWeatherForecast(data: data) : Container(),
            ],
          ),
        );
      },
    );
  }
}

class ListViewHourlyWeatherForecast extends StatefulWidget {
  final DataWeather? data;

  const ListViewHourlyWeatherForecast({super.key, this.data});

  @override
  State<ListViewHourlyWeatherForecast> createState() => _ListViewHourlyWeatherForecastState();
}

class _ListViewHourlyWeatherForecastState extends State<ListViewHourlyWeatherForecast> {
  final ScrollController _controller = ScrollController();

  void scrollToIndex(int index) {
    _controller.animateTo(
      index * 100.0,
      duration: Duration(seconds: 1),
      curve: Curves.easeInOut,
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //
    // WidgetsBinding.instance.addPostFrameCallback((_) {
    //   scrollToIndex(6);
    // });
  }

  @override
  Widget build(BuildContext context) {
    final data = widget.data;
    return SizedBox(
      height: Dimens.getProportionalScreenHeight(context, 110),
      child: ListView.builder(
        controller: _controller,
        shrinkWrap: true,
        padding: EdgeInsets.zero,
        itemCount: data?.hourlyWeatherForecast?.length ?? 0,
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        itemBuilder: (BuildContext context, int index) {
          String currentTime = DateFormat('HH:mm:ss').format(DateTime.now());
          String currentHour = currentTime.substring(0, 2);

          String forecastTime = data?.hourlyWeatherForecast?[index].time.substring(11, 16) ?? '';
          String forecastHour = data?.hourlyWeatherForecast?[index].time.substring(11, 13) ?? '';

          String forecastTemperature =
              data?.hourlyWeatherForecast?[index].temperature.round().toString() ?? '';
          return Container(
            padding: const EdgeInsets.symmetric(vertical: 10),
            margin: const EdgeInsets.only(right: 10),
            width: 65,
            decoration: currentHour == forecastHour ? ShapeDecoration(
              color: currentHour == forecastHour ? Colors.white : const Color(0xFF3494D6),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            ): ShapeDecoration(
              gradient: LinearGradient(
                begin: const Alignment(-1.00, -0.04),
                end: const Alignment(1, 0.04),
                colors: [Colors.white.withOpacity(0.23999999463558197), Colors.white.withOpacity(0.07999999821186066)],
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),

            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  forecastTime,
                  style: const TextStyle(
                    fontSize: 14,
                    color: AppColors.greyColor,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Image.asset(
                  AppColors.pathIconWeather(),
                  width: 18,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      forecastTemperature,
                      style: const TextStyle(
                        color: AppColors.greyColor,
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const Text(
                      '°',
                      style: TextStyle(
                        color: AppColors.greyColor,
                        fontWeight: FontWeight.w600,
                        fontSize: 17,
                        fontFeatures: [
                          FontFeature.enable('sups'),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
