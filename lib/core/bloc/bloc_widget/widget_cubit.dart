import 'package:app_settings/app_settings.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart' as dio;
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:myweatherapp/configs/app_navigator.dart';
import 'package:myweatherapp/configs/constants/values/colors.dart';

///Created by Nguyen Huu Tuong on 12/12/2023.

abstract class WidgetCubit<State> extends Cubit<State> {
  void onWidgetCreated();

  WidgetCubit({required State widgetState}) : super(widgetState) {

    WidgetsBinding.instance.addPostFrameCallback((_) {
      onWidgetCreated();
    });
  }
  String language = 'vi';

  void showToast(
    String? message, {
    Toast toastLength = Toast.LENGTH_LONG,
    ToastGravity toastGravity = ToastGravity.CENTER,
    int timeInSecForIosWeb = 1,
    double? fontSize = 14,
    Color? backgroundColor,
    Color? textColor,
    bool webShowClose = false,
  }) {
    if ((message?.isNotEmpty ?? false) == true) {
      Fluttertoast.showToast(
          msg: message!,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          backgroundColor: backgroundColor,
          textColor: textColor,
          fontSize: fontSize);
    }
  }

  void showErrorToast(String? message) => showToast(message, backgroundColor: AppColors.red);

  void showSuccessToast(String? message) => showToast(message, backgroundColor: AppColors.green);

  void showNormalToast(String? message) =>
      showToast(message, backgroundColor: AppColors.grey, toastGravity: ToastGravity.BOTTOM);

  void showAdaptiveDialog(
      {required BuildContext context,
      String? title,
      required String content,
      Function()? onOkPress,
      Function()? onCancelPress}) {
    if (Theme.of(context).platform == TargetPlatform.iOS) {
      showCupertinoDialog(
        context: context,
        builder: (context) {
          return CupertinoAlertDialog(
            title: Text(title ?? "Notification"),
            content: Text(content),
            actions: <Widget>[
              CupertinoDialogAction(
                child: Text("Cancel"),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              CupertinoDialogAction(
                child: Text("OK"),
                onPressed: onOkPress ??
                    () {
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
            title: Text(title ?? "Notification"),
            content: Text(content),
            actions: <Widget>[
              TextButton(
                child: Text("Cancel"),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              TextButton(
                child: Text("OK"),
                onPressed: onOkPress ??
                    () {
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

  //Function for call api, handle data loading, data error
  Future<dynamic> fetchApi(Function() apiFunction,
      {bool showLoading = true,
      bool checkInternetBeforeFetchingData = true,
      bool showToastError = true,}) async {
    final hasInternetConnection = await Connectivity().checkConnectivity() != ConnectivityResult.none;

    //if device not connect to wifi or mobile data, show dialog
    if (checkInternetBeforeFetchingData) {
      if (!hasInternetConnection) {
        // showAdaptiveDialog(
        //     context: AppNavigator.navigatorKey.currentContext!,
        //     content: "Please check internet connection",
        //     onOkPress: () {
        //       AppSettings.openAppSettingsPanel(AppSettingsPanelType.wifi);
        //     });
        showNormalToast("Please check internet connection");
        // showErrorToast(S.current.connection_error);
      }
    }

    //check loading, show loading before fetch api
    if (showLoading && hasInternetConnection) {
      EasyLoading.show(
        status: 'loading...',
        maskType: EasyLoadingMaskType.none,
      );
    }
    try {
      // ignore: avoid_dynamic_calls
      final response = await apiFunction.call();
      //hide loading after receive api response
      if (showLoading) {
        EasyLoading.dismiss();
      }
      return response;
    } catch (err) {
      if (showLoading) {
        EasyLoading.dismiss();
      }
      handleApiError(showLoading,err);
      return Future.value();
    }
  }

  @override
  close() async {
    super.close();

    stream.drain();
  }

  Future handleApiError(bool  showLoading,err) async {
    if (err is dio.DioException && !isClosed) {
      if (kDebugMode) {
        print(err.requestOptions.path);
        print(err.requestOptions.uri);
        print(err.requestOptions.headers);
        print(err.requestOptions.queryParameters);
        print(err.requestOptions.data);
        print(err.requestOptions.extra);
        print('Response: ');
        print(err.response);
        print(err.error);
      }
    } else {
      if (!isClosed) {
        showErrorToast("Something city went wrong");
        // showErrorToast(err.toString());
      }
      if (kDebugMode) {
        print(err.toString());
      }
    }
  }

  Future<void> handleApiResponse(
      {bool showLoading = true, bool showToastError = true, bool showToastException = true}) async {
    //hide loading after receive api response
    if (showLoading) {
      EasyLoading.dismiss();
    }
  }
}

extension ObjectExtension<T> on T {
  R let<R>(R Function(T it) function) => function(this);

  bool isNull() => this == null;

  bool isNotNull() => this != null;

  bool isNotIn(List<T> list) {
    if (this == null) {
      return false;
    }
    return !list.contains(this);
  }

  bool isIn(List<T> list) {
    return list.contains(this);
  }
}
