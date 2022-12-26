part of 'weather_cubit.dart';

enum WeatherStatus { initial, loading, loaded, error }

class WeatherState extends Equatable {
  final WeatherStatus status;
  final WeatherModel weather;
  final CustomError error;
  const WeatherState({
    required this.error,
    required this.status,
    required this.weather,
  });

  @override
  List<Object> get props => [status, weather, error];

  @override
  bool get stringify => true;

  WeatherState copyWith({
    WeatherStatus? status,
    WeatherModel? weather,
    CustomError? error,
  }) {
    return WeatherState(
      status: status ?? this.status,
      weather: weather ?? this.weather,
      error: error ?? this.error,
    );
  }

  factory WeatherState.initial() {
    return WeatherState(
      error: const CustomError(),
      status: WeatherStatus.initial,
      weather: WeatherModel.initial(),
    );
  }
}
