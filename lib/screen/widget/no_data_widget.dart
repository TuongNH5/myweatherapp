import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

///Created by Nguyen Huu Tuong on 09/11/2023.
class NoDataWidget extends StatelessWidget {
  const NoDataWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            "assets/no_data.png",
          ),
          const Text(
            'Please enter a city name other.....',
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
        ],
      ),
    );
  }
}
