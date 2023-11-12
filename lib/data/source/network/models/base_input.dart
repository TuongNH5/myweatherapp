
import 'package:myweatherapp/data/source/network/base_model.dart';

///Created by Nguyen Huu Tuong on 12/12/2023.


class BaseInput extends BaseModel {
  BaseInput({this.data}) : super.init();
  final Map<String, dynamic>? data;

  @override
  Map<String, dynamic> toJson() {
    return data != null ? data! : <String, dynamic>{};
  }

  factory BaseInput.fromJson(Map<String, dynamic> json) {
    return BaseInput(
      data: json['data'] as Map<String, dynamic>?,
    );
  }

  factory BaseInput.fromMap(Map<String, dynamic> map) {
    return BaseInput(
      data: map['data'] as Map<String, dynamic>?,
    );
  }
}
