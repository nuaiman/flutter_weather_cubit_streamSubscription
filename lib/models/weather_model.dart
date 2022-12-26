import 'package:equatable/equatable.dart';

class WeatherModel extends Equatable {
  final String name;
  final String description;
  final String country;
  final String icon;
  final DateTime lastUpdated;
  final double temp;
  final double tempMin;
  final double tempMax;
  const WeatherModel({
    required this.name,
    required this.description,
    required this.country,
    required this.icon,
    required this.lastUpdated,
    required this.temp,
    required this.tempMin,
    required this.tempMax,
  });

  @override
  List<Object> get props {
    return [
      name,
      description,
      country,
      icon,
      lastUpdated,
      temp,
      tempMin,
      tempMax,
    ];
  }

  @override
  bool get stringify => true;

  WeatherModel copyWith({
    String? name,
    String? description,
    String? country,
    String? icon,
    DateTime? lastUpdated,
    double? temp,
    double? tempMin,
    double? tempMax,
  }) {
    return WeatherModel(
      name: name ?? this.name,
      description: description ?? this.description,
      country: country ?? this.country,
      icon: icon ?? this.icon,
      lastUpdated: lastUpdated ?? this.lastUpdated,
      temp: temp ?? this.temp,
      tempMin: tempMin ?? this.tempMin,
      tempMax: tempMax ?? this.tempMax,
    );
  }

  factory WeatherModel.fromJson(Map<String, dynamic> json) {
    final weather = json['weather'][0];
    final main = json['main'];
    return WeatherModel(
      name: '',
      description: weather['description'],
      country: '',
      icon: weather['icon'],
      lastUpdated: DateTime.now(),
      temp: main['temp'],
      tempMin: main['temp_min'],
      tempMax: main['temp_max'],
    );
  }

  factory WeatherModel.initial() {
    return WeatherModel(
      name: '',
      description: '',
      country: '',
      icon: '',
      lastUpdated: DateTime(1920),
      temp: 1000,
      tempMin: 1000,
      tempMax: 1000,
    );
  }
}
