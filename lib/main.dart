import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_cubit_weather_app/cubits/app_theme/app_theme_cubit.dart';
import 'cubits/temp_setting/temp_setting_cubit.dart';
import 'cubits/weather/weather_cubit.dart';
import 'repositories/weather_repository.dart';
import 'services/weatherapi_services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

import 'screens/home_screen.dart';

void main() async {
  await dotenv.load(fileName: '.env');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) => WeatherRepository(
          weatherApiServices: WeatherApiServices(httpClient: http.Client())),
      child: MultiBlocProvider(
        providers: [
          BlocProvider<WeatherCubit>(
            create: (context) => WeatherCubit(
                weatherRepository: context.read<WeatherRepository>()),
          ),
          BlocProvider<TempSettingCubit>(
            create: (context) => TempSettingCubit(),
          ),
          BlocProvider<AppThemeCubit>(
            create: (context) =>
                AppThemeCubit(weatherCubit: context.read<WeatherCubit>()),
          ),
        ],
        child: BlocBuilder<AppThemeCubit, AppThemeState>(
          builder: (context, state) {
            return MaterialApp(
              title: 'Flutter Weather',
              debugShowCheckedModeBanner: false,
              theme: state.appThemeMode == AppThemeMode.light
                  ? ThemeData.light().copyWith(brightness: Brightness.dark)
                  : ThemeData.dark().copyWith(brightness: Brightness.dark),
              home: const HomeScreen(),
            );
          },
        ),
      ),
    );
  }
}
