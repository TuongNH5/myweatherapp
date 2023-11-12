import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';

import '../../data/source/network/data_weather.dart';
import '../../presentation/screen/detail_screen.dart';
import '../../presentation/screen/home_screen.dart';


part 'app_router.gr.dart';

@AutoRouterConfig()
class AppRouter extends _$AppRouter {
  @override
  // TODO: implement routes
  List<AutoRoute> get routes => [
        AutoRoute(page: HomeRoute.page,path:  AppRouterPath.home,initial: true),
        AutoRoute(page: DetailRoute.page,path:  AppRouterPath.detail),

      ];
}

class AppRouterPath {
   static const home = '/home';
    static const detail = '/detail';

}
