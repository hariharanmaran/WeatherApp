import 'dart:convert';
import 'package:http/http.dart' as http;

class WeatherService {
  final String apiKey = "ca5e0e6b9ab0854a8deb0d552ef8d89f"; // your key
  final String baseUrl = "https://api.openweathermap.org/data/2.5";

  Future<Map<String, dynamic>> fetchWeather(String city) async {
    final response = await http.get(
      Uri.parse("$baseUrl/weather?q=$city&appid=$apiKey&units=metric"),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception("Failed to load weather data");
    }
  }

  Future<Map<String, dynamic>> fetchForecast(String city) async {
    final response = await http.get(
      Uri.parse("$baseUrl/forecast?q=$city&appid=$apiKey&units=metric"),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception("Failed to load forecast data");
    }
  }
}
