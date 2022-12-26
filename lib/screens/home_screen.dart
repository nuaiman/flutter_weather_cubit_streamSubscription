import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recase/recase.dart';

import '../constants/constants.dart';
import '../cubits/temp_setting/temp_setting_cubit.dart';
import '../cubits/weather/weather_cubit.dart';
import '../widgets/error_dialog.dart';
import 'search_screen.dart';
import 'setting_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String showTemp(double temp) {
    final currentTempUnit = context.watch<TempSettingCubit>().state.tempUnit;
    if (currentTempUnit == TempUnit.farenheit) {
      return '${((temp * 9 / 5) + 32).toStringAsFixed(2)} ℉';
    }
    return '${temp.toStringAsFixed(2)} ℃';
  }

  Widget showIcon(String icon) {
    return FadeInImage.assetNetwork(
      placeholder: 'assets/images/loading.gif',
      image: 'https://$kIconHost/img/wn/$icon@4x.png',
      width: 200,
      height: 200,
    );
  }

  Widget formatText(String description) {
    final formattedString = description.titleCase;
    return Text(
      formattedString,
      style: const TextStyle(fontSize: 24),
      textAlign: TextAlign.center,
    );
  }

  String? _city;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Weather'),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () async {
              _city = await Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const SearchScreen(),
                ),
              );
              if (_city != null) {
                context.read<WeatherCubit>().fetchWeather(_city!);
              }
            },
          ),
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const SettingScreen(),
                ),
              );
            },
          )
        ],
      ),
      body: _showWeather(),
    );
  }

  Widget _showWeather() {
    return BlocConsumer<WeatherCubit, WeatherState>(
      listener: (context, state) {
        if (state.status == WeatherStatus.error) {
          errorDialog(context, state.error.errorMsg);
        }
      },
      builder: (context, state) {
        if (state.status == WeatherStatus.initial) {
          return const Center(
            child: Text(
              'Search a city',
              style: TextStyle(fontSize: 20),
            ),
          );
        }
        if (state.status == WeatherStatus.loading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        if (state.status == WeatherStatus.error && state.weather.name == '') {
          return const Center(
            child: Text(
              'Search a city',
              style: TextStyle(fontSize: 20),
            ),
          );
        }
        return ListView(
          children: [
            SizedBox(height: MediaQuery.of(context).size.height / 10),
            showIcon(state.weather.icon),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  TimeOfDay.fromDateTime(state.weather.lastUpdated)
                      .format(context),
                  style: const TextStyle(fontSize: 18),
                ),
                const SizedBox(width: 10),
                Text(
                  '(${state.weather.country})',
                  style: const TextStyle(fontSize: 18),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Text(
              state.weather.name,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            Text(
              showTemp(state.weather.temp),
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  children: [
                    const Icon(Icons.arrow_upward),
                    Text(
                      showTemp(state.weather.tempMin),
                      style: const TextStyle(fontSize: 16),
                    ),
                  ],
                ),
                const SizedBox(width: 20),
                const Text(
                  '|',
                  style: TextStyle(fontSize: 30),
                ),
                const SizedBox(width: 20),
                Row(
                  children: [
                    Text(
                      showTemp(state.weather.tempMax),
                      style: const TextStyle(fontSize: 16),
                    ),
                    const Icon(Icons.arrow_downward),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 20),
            formatText(state.weather.description),
          ],
        );
      },
    );
  }
}
