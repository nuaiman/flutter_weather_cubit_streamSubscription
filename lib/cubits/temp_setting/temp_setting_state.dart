part of 'temp_setting_cubit.dart';

enum TempUnit { celsius, farenheit }

class TempSettingState extends Equatable {
  final TempUnit tempUnit;
  const TempSettingState({this.tempUnit = TempUnit.celsius});

  @override
  List<Object> get props => [tempUnit];

  @override
  bool get stringify => true;

  TempSettingState copyWith({
    TempUnit? tempUnit,
  }) {
    return TempSettingState(
      tempUnit: tempUnit ?? this.tempUnit,
    );
  }

  factory TempSettingState.initial() {
    return const TempSettingState();
  }
}
