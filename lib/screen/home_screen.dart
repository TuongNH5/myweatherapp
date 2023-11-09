import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:ui';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:myweatherapp/screen/widget/body_home_widget.dart';
import 'package:myweatherapp/screen/widget/footer_widget.dart';
import 'package:myweatherapp/screen/widget/textfield_widget.dart';

import '../configs/constants/constants.dart';
import 'cubit/weather_cubit.dart';

@RoutePage()
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    // return UIHomeWidget();
    return BlocProvider(
      create: (context) => WeatherCubit(),
      child: UIHomeWidget(),
    );
  }
}

class UIHomeWidget extends StatefulWidget {
  const UIHomeWidget({super.key});

  @override
  State<UIHomeWidget> createState() => _UIHomeWidgetState();
}

class _UIHomeWidgetState extends State<UIHomeWidget> {
  final TextEditingController _cityController = TextEditingController();

  String location = 'Ho chi minh';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<WeatherCubit>().fetchApiGetWeather(city: 'Ho chi minh');
    ();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: SystemUiOverlay.values);
    Size size = MediaQuery.of(context).size;
    return BlocBuilder<WeatherCubit, WeatherSuccessState>(
      builder: (context, state) {
        final data = state.weatherData;
        // if (data?.currentDate?.isNotEmpty == true) {
        //   print('data ${data?.currentDate}');
        // }
        return Scaffold(
            backgroundColor: Colors.white,
            body: Container(
                width: size.width,
                height: size.height,
                padding: const EdgeInsets.only(top: 70, left: 10, right: 10),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: Constants.setBackgroundColorWeather(),
                  ),
                ),
                child: data?.currentDate?.isNotEmpty == true
                    ? SingleChildScrollView(
                        child: Column(
                          children: [
                            TextfieldWidget(),
                            const BodyHomeWidget(),
                            const FooterWidget(),
                          ],
                        ),
                      ): const Center(child: CircularProgressIndicator(),)

                    // : const NoDataWidget()
            ));
      },
    );
  }
}

// : CircularProgressIndicator()
void showAdaptiveDialog(BuildContext context) {
  if (Theme.of(context).platform == TargetPlatform.iOS) {
    showCupertinoDialog(
      context: context,
      builder: (context) {
        return CupertinoAlertDialog(
          title: Text("Notification"),
          content: Text("This is the dialog content."),
          actions: <Widget>[
            CupertinoDialogAction(
              child: Text("Cancel"),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            CupertinoDialogAction(
              child: Text("OK"),
              onPressed: () {
                // Handle the OK button action
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  } else {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Notification"),
          content: Text("This is the dialog content."),
          actions: <Widget>[
            TextButton(
              child: Text("Cancel"),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            TextButton(
              child: Text("OK"),
              onPressed: () {
                // Handle the OK button action
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }
}
