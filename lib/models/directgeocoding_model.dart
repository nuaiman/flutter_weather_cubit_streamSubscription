import 'package:equatable/equatable.dart';

class DirectGeocodingModel extends Equatable {
  final String name;
  final String country;
  final double lat;
  final double lon;
  const DirectGeocodingModel({
    required this.name,
    required this.country,
    required this.lat,
    required this.lon,
  });

  @override
  List<Object> get props => [name, country, lat, lon];

  @override
  bool get stringify => true;

  DirectGeocodingModel copyWith({
    String? name,
    String? country,
    double? lat,
    double? lon,
  }) {
    return DirectGeocodingModel(
      name: name ?? this.name,
      country: country ?? this.country,
      lat: lat ?? this.lat,
      lon: lon ?? this.lon,
    );
  }

  factory DirectGeocodingModel.fromJson(List<dynamic> json) {
    final Map<String, dynamic> data = json[0];
    return DirectGeocodingModel(
      name: data['name'],
      country: data['country'],
      lat: data['lat'],
      lon: data['lon'],
    );
  }
}
