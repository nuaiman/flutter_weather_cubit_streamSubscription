import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'temp_setting_state.dart';

class TempSettingCubit extends Cubit<TempSettingState> {
  TempSettingCubit() : super(TempSettingState.initial());

  void toggleTempUnit() {
    emit(
      state.copyWith(
        tempUnit: state.tempUnit == TempUnit.celsius
            ? TempUnit.farenheit
            : TempUnit.celsius,
      ),
    );
  }
}
