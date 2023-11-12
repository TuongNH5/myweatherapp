import 'package:auto_route/annotations.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:myweatherapp/configs/constants/values/colors.dart';
import 'package:myweatherapp/configs/constants/values/dimens.dart';
import '../../data/source/network/data_weather.dart';

@RoutePage()
class DetailScreen extends StatelessWidget {
  final List<DailyForecast>? list;

  DetailScreen({super.key, this.list});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: SystemUiOverlay.values);
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        width: size.width,
        height: size.height,
        padding:  EdgeInsets.only(top: Dimens.getProportionalScreenHeight(context, 70), left: 10, right: 10),
        decoration:  BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: AppColors.setBackgroundColorWeather()
            ,
          ),
        ),
        child: Column(
          children: [
            //Appbar
            Row(
              children: [
                IconButton(
                  color: Colors.white,
                  icon: const Icon(Icons.arrow_back),
                  onPressed: () {
                    Navigator.pop(context); // Navigate back when the back button is pressed
                  },
                ),
                const SizedBox(
                  width: 10,
                ),
                const Text(
                  'Forecasts',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
            Expanded(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: ListView.separated(
                  padding: EdgeInsets.zero,
                  itemCount: list?.length ?? 0,
                  itemBuilder: (context, index) {
                    final data = list?[index];
                    return Card(
                      elevation: 3.0,
                      margin: const EdgeInsets.only(bottom: 20),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  'Date: ${data?.date ?? ''}',
                                  style: const TextStyle(
                                    color: Color(0xff6696f5),
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                Text(
                                  data?.currentWeatherStatus ?? '',
                                  style: const TextStyle(
                                    color: AppColors.greyColor,
                                    // fontSize: 30,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [

                                Row(
                                  children: [
                                    Image.asset(
                                      "assets/fog.png",
                                      width: 20,
                                      height: 20,
                                    ),
                                    Text(
                                      "${data?.minTemperature}",
                                      style: const TextStyle(
                                        fontSize: 16,
                                        color: Colors.grey,
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Image.asset(
                                      "assets/high_temperature.png",
                                      width: 20,
                                    ),
                                    Text(
                                      "${data?.maxTemperature}",
                                      style: const TextStyle(
                                        fontSize: 16,
                                        color: Colors.grey,
                                      ),
                                    ),
                                  ],
                                )
                              ],)
                          ],
                        ),
                      ),
                    );
                  },
                  separatorBuilder: (context, position) {
                    return const SizedBox(
                      height: 8,
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

}
