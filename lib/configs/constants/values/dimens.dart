import 'package:flutter/material.dart';

/**
    ///Created by Nguyen Huu Tuong on 12/12/2023.
 */

class Dimens {
  static const double figmaWidth = 414;
  static const double figmaHeight = 896;
  static double getScreenWidth(BuildContext context) {
    return MediaQuery.of(context).size.width;
  }

  static double getScreenHeight(BuildContext context) {
    return MediaQuery.of(context).size.height;
  }

  static double getProportionalScreenWidth(BuildContext context, double width) {
    return (width / figmaWidth) * MediaQuery.of(context).size.width;
  }

  static double getProportionalScreenHeight(BuildContext context, double height) {
    return (height / figmaHeight) * MediaQuery.of(context).size.height;
  }
}
