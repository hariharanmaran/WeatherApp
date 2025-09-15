import 'package:get/get.dart';
import '../services/weather_service.dart';

class WeatherController extends GetxController {
  final WeatherService _weatherService = WeatherService();

  var weatherData = {}.obs;
  var forecastData = {}.obs;
  var isLoading = false.obs;

  Future<void> getWeather(String city) async {
    try {
      isLoading.value = true;

      final weather = await _weatherService.fetchWeather(city);
      final forecast = await _weatherService.fetchForecast(city);

      weatherData.value = weather;
      forecastData.value = forecast;
    } catch (e) {
      Get.snackbar("Error", "Could not fetch weather data");
    } finally {
      isLoading.value = false;
    }
  }
}
