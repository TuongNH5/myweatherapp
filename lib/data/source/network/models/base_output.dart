
import 'package:myweatherapp/data/source/network/base_model.dart';
///Created by Nguyen Huu Tuong on 12/12/2023.

class BaseOutput extends BaseModel {
  int? statusCode;
  String? message;

  BaseOutput({this.statusCode, this.message}) : super.init();
  BaseOutput.init({this.statusCode, this.message}) : super.init();
  BaseOutput.fromJson(dynamic json)
      : super.fromJson(json as Map<String, dynamic>) {
    statusCode = json['statusCode'];
    message = json['message'];
  }

  @override
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['statusCode'] = statusCode;
    map['message'] = message;
    return map;
  }

  BaseOutput copyWith({
    int? statusCode,
    String? message,
  }) {
    return BaseOutput(
      statusCode: statusCode ?? this.statusCode,
      message: message ?? this.message,
    );
  }
}
