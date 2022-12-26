import '../exceptions/http_exceptions.dart';
import '../models/custom_error.dart';
import '../models/directgeocoding_model.dart';
import '../models/weather_model.dart';
import '../services/weatherapi_services.dart';

class WeatherRepository {
  final WeatherApiServices weatherApiServices;
  const WeatherRepository({required this.weatherApiServices});

  Future<WeatherModel> fetchWeather(String city) async {
    try {
      final DirectGeocodingModel directGeocoding =
          await weatherApiServices.getDirectGeocoding(city);

      final WeatherModel tempWeather =
          await weatherApiServices.getWeather(directGeocoding);

      final WeatherModel weather = tempWeather.copyWith(
        name: directGeocoding.name,
        country: directGeocoding.country,
      );
      return weather;
    } on WeatherException catch (e) {
      throw CustomError(errorMsg: e.message);
    } catch (e) {
      throw CustomError(errorMsg: e.toString());
    }
  }
}
