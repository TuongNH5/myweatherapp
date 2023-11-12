
import 'package:flutter/material.dart';
import 'package:myweatherapp/configs/auto_router/app_router.dart';
///Created by Nguyen Huu Tuong on 12/12/2023.

class AppNavigator {
  static String? currentRoute;
  static AppRouter rootRouter = AppRouter();
  static final AppNavigator _instance = AppNavigator();

  static AppNavigator get instance => _instance;

  static NavigatorState? get state => rootRouter.navigatorKey.currentState;
  static GlobalKey<NavigatorState> navigatorKey = rootRouter.navigatorKey;
}
