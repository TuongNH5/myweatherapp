import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubit/weather_cubit.dart';

class TextfieldWidget extends StatelessWidget {
  TextfieldWidget({super.key});

  final TextEditingController _cityController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return TextField(
      style: const TextStyle(color: Colors.white),
      onSubmitted: (value) {
        context.read<WeatherCubit>().fetchApiGetWeather(city: value.toString());
      },
      controller: _cityController,
      autofocus: false,
      decoration: InputDecoration(
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(width: 1, color: Colors.white), //<-- SEE HERE
          ),
          hintStyle: const TextStyle(color: Colors.white),
          suffixStyle: const TextStyle(color: Colors.white),
          prefixIcon: const Icon(
            Icons.search,
            color: Colors.white,
          ),
          suffixIcon: GestureDetector(
            onTap: () => _cityController.clear(),
            child: const Icon(
              Icons.close,
              color: Colors.white,
            ),
          ),
          hintText: 'Search city e.g',
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              color: Colors.white,
            ),
            borderRadius: BorderRadius.circular(10),
          )),
    );
  }
}
