///Created by Nguyen Huu Tuong on 12/12/2023.
abstract class BaseModel {
  BaseModel();
  BaseModel.init();
  BaseModel.fromJson(Map<String, dynamic> json);
  Map<String, dynamic> toJson();
}
