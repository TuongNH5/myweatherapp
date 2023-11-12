import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:ui';
import 'package:flutter/services.dart';
import 'package:myweatherapp/configs/constants/values/colors.dart';
import 'package:myweatherapp/configs/constants/values/dimens.dart';
import 'package:myweatherapp/presentation/screen/widget/body_home_widget.dart';
import 'package:myweatherapp/presentation/screen/widget/footer_widget.dart';
import 'package:myweatherapp/presentation/screen/widget/textfield_widget.dart';
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
    print('build HomeScreen');
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
    print('initState UIHomeWidget');
    context.read<WeatherCubit>().fetchApiGetWeather(city: 'Ho chi minh');
    ();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: SystemUiOverlay.values);
    Size size = MediaQuery.of(context).size;
    return BlocBuilder<WeatherCubit, WeatherState>(
      builder: (context, state) {
        final data = state.dataWeather;
        // if (data?.currentDate?.isNotEmpty == true) {
        //   print('data ${data?.currentDate}');
        // }
        return Scaffold(
            backgroundColor: Colors.white,
            body: Container(
                width: size.width,
                height: size.height,
                padding:  EdgeInsets.only(top: Dimens.getProportionalScreenHeight(context, 70), left: 10, right: 10, bottom: Dimens.getProportionalScreenHeight(context, 20)),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: AppColors.setBackgroundColorWeather(),
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
                      ): Container()

                    // : const NoDataWidget()
            ));
      },
    );
  }
}

// : CircularProgressIndicator()
