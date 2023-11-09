/// Created by Nguyen Huu Tu on 28/03/2022.
import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';


class AppConfig {
  String? baseUrl;
  AppConfig._init();

  static Future<AppConfig> production() async {
    final appConfig = AppConfig._init();
    return appConfig.loadConfig();
  }

  Future<AppConfig> loadConfig() async {
    //Read config from .env file
    try {
      await dotenv.load();
      baseUrl = dotenv.env[ConfigConstants.domainProduction] ?? '';

    }
     catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
    return this;

  }
}

class ConfigConstants {
  static const domainProduction = 'DOMAIN_PRODUCTION';

}

