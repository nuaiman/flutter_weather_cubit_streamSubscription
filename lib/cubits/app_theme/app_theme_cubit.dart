import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc_cubit_weather_app/constants/constants.dart';
import 'package:flutter_bloc_cubit_weather_app/cubits/weather/weather_cubit.dart';

part 'app_theme_state.dart';

class AppThemeCubit extends Cubit<AppThemeState> {
  late final StreamSubscription themeSubscription;
  final WeatherCubit weatherCubit;
  AppThemeCubit({required this.weatherCubit}) : super(AppThemeState.initial()) {
    themeSubscription = weatherCubit.stream.listen((WeatherState weatherState) {
      if (weatherState.weather.temp > kWarmOrNot) {
        emit(state.copyWith(appThemeMode: AppThemeMode.light));
      } else {
        emit(state.copyWith(appThemeMode: AppThemeMode.dark));
      }
    });
  }

  @override
  Future<void> close() {
    themeSubscription.cancel();
    return super.close();
  }
}
