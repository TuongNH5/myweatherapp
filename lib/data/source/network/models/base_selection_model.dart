import 'package:flutter/material.dart';
///Created by Nguyen Huu Tuong on 12/12/2023.

class BaseSelectionModel<T> {
  bool isSelected = false;
  final T data;
  BaseSelectionModel({
    this.isSelected = false,
    required this.data,
  });
}

mixin BaseSelectionModelMixin {
  bool isSelected = false;
  String? title;
  Widget? icon;
}
