import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/weather_controller.dart';

class ForecastPage extends StatelessWidget {
  final WeatherController controller = Get.find();

  ForecastPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1E2A47),
      appBar: AppBar(
        title: const Text("7-Day Forecast"),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Obx(() {
        if (controller.forecastData.isEmpty) {
          return const Center(
              child: Text("No forecast available",
                  style: TextStyle(color: Colors.white70)));
        }

        final forecastList = controller.forecastData["list"];

        return ListView.builder(
          itemCount: forecastList.length,
          itemBuilder: (context, index) {
            final item = forecastList[index];
            final date = item['dt_txt'];
            final temp = item['main']['temp'].round();
            final desc = item['weather'][0]['description'];
            final icon = item['weather'][0]['icon'];

            return Card(
              color: Colors.white10,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15)),
              margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
              child: ListTile(
                leading: Image.network(
                  "http://openweathermap.org/img/wn/$icon.png",
                  scale: 1.5,
                ),
                title: Text(
                  "$temp°C - ${desc.toUpperCase()}",
                  style: const TextStyle(color: Colors.white, fontSize: 16),
                ),
                subtitle: Text(
                  date,
                  style: const TextStyle(color: Colors.white70),
                ),
              ),
            );
          },
        );
      }),
    );
  }
}
