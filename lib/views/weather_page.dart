import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/weather_controller.dart';
import 'forecast_page.dart';

class WeatherPage extends StatelessWidget {
  final WeatherController controller = Get.put(WeatherController());
  final TextEditingController cityController = TextEditingController();

  WeatherPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1E2A47),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // 🔍 Search Bar
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: cityController,
                      style: const TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        hintText: "Search city...",
                        hintStyle: const TextStyle(color: Colors.white70),
                        filled: true,
                        fillColor: Colors.white12,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide.none,
                        ),
                        contentPadding:
                            const EdgeInsets.symmetric(horizontal: 16),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blueAccent,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 14),
                    ),
                    onPressed: () {
                      if (cityController.text.isNotEmpty) {
                        controller.getWeather(cityController.text);
                      }
                    },
                    child: const Icon(Icons.search, color: Colors.white),
                  ),
                ],
              ),
              const SizedBox(height: 30),

              // 🌦 Weather Info
              Obx(() {
                if (controller.isLoading.value) {
                  return const Center(
                      child: CircularProgressIndicator(color: Colors.white));
                }

                if (controller.weatherData.isEmpty) {
                  return const Text(
                    "Search a city to see weather 🌍",
                    style: TextStyle(color: Colors.white70, fontSize: 18),
                  );
                }

                final weather = controller.weatherData;
                final icon = weather['weather'][0]['icon'];

                return Column(
                  children: [
                    // Weather Icon
                    Image.network(
                      "http://openweathermap.org/img/wn/$icon@2x.png",
                      scale: 0.7,
                    ),

                    // Temperature
                    Text(
                      "${weather['main']['temp'].round()}°C",
                      style: const TextStyle(
                        fontSize: 60,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),

                    // Condition
                    Text(
                      "${weather['weather'][0]['description']}".toUpperCase(),
                      style: const TextStyle(
                        fontSize: 20,
                        color: Colors.white70,
                      ),
                    ),
                    const SizedBox(height: 20),

                    // Extra Info
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        _infoCard("💧", "${weather['main']['humidity']}%",
                            "Humidity"),
                        _infoCard(
                            "🌬", "${weather['wind']['speed']} m/s", "Wind"),
                        _infoCard("🌡", "${weather['main']['feels_like']}°C",
                            "Feels Like"),
                      ],
                    ),
                    const SizedBox(height: 30),

                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white24,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 40, vertical: 14),
                      ),
                      onPressed: () {
                        Get.to(() => ForecastPage());
                      },
                      child: const Text("7-Day Forecast",
                          style: TextStyle(color: Colors.white, fontSize: 18)),
                    ),
                  ],
                );
              }),
            ],
          ),
        ),
      ),
    );
  }

  Widget _infoCard(String emoji, String value, String label) {
    return Column(
      children: [
        Text(emoji, style: const TextStyle(fontSize: 28)),
        const SizedBox(height: 6),
        Text(
          value,
          style: const TextStyle(
              color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
        ),
        Text(
          label,
          style: const TextStyle(color: Colors.white70, fontSize: 14),
        ),
      ],
    );
  }
}
