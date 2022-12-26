import 'dart:convert';

import '../constants/constants.dart';
import '../exceptions/http_exceptions.dart';
import '../models/directgeocoding_model.dart';
import '../models/weather_model.dart';
import 'http_error_handler.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

class WeatherApiServices {
  final http.Client httpClient;
  const WeatherApiServices({required this.httpClient});

  Future<DirectGeocodingModel> getDirectGeocoding(String city) async {
    final Uri uri = Uri(
      scheme: 'https',
      host: kApiHost,
      path: '/geo/1.0/direct',
      queryParameters: {
        'q': city,
        'limit': kLimit,
        'appid': dotenv.env['APPID'],
      },
    );

    try {
      final http.Response response = await httpClient.get(uri);
      if (response.statusCode != 200) {
        throw httpErrorHandler(response);
      }
      final responseBody = json.decode(response.body);
      if (responseBody.isEmpty) {
        throw WeatherException(message: '$city not found');
      }
      final directGeocoding = DirectGeocodingModel.fromJson(responseBody);
      return directGeocoding;
    } catch (e) {
      rethrow;
    }
  }

  // ---------------------------------------------------------------------------

  Future<WeatherModel> getWeather(DirectGeocodingModel directGeocoding) async {
    final Uri uri = Uri(
      scheme: 'https',
      host: kApiHost,
      path: '/data/2.5/weather',
      queryParameters: {
        'lat': '${directGeocoding.lat}',
        'lon': '${directGeocoding.lon}',
        'units': kUnit,
        'appid': dotenv.env['APPID'],
      },
    );

    try {
      final http.Response response = await httpClient.get(uri);
      if (response.statusCode != 200) {
        throw Exception(httpErrorHandler(response));
      }
      final weatherJson = json.decode(response.body);
      final WeatherModel weather = WeatherModel.fromJson(weatherJson);
      return weather;
    } catch (e) {
      rethrow;
    }
  }
}
