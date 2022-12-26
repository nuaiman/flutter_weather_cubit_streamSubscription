import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubits/temp_setting/temp_setting_cubit.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Settings')),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: Card(
          child: ListTile(
            leading: CircleAvatar(
                child: Text(context.watch<TempSettingCubit>().state.tempUnit ==
                        TempUnit.celsius
                    ? '℃'
                    : '℉')),
            title: const Text('Temperature Unit'),
            subtitle: const Text('Celsius/Farenheit'),
            trailing: Switch(
              value: context.watch<TempSettingCubit>().state.tempUnit ==
                  TempUnit.celsius,
              onChanged: (_) {
                context.read<TempSettingCubit>().toggleTempUnit();
              },
            ),
          ),
        ),
      ),
    );
  }
}
