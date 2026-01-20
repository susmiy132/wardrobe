import 'package:flutter/material.dart';
import '../models/clothing_model.dart';
import '../services/wardrobe_api_service.dart';
import '../widgets/clothing_card.dart';

class WeatherRecommendScreen extends StatefulWidget {
  const WeatherRecommendScreen({super.key});

  @override
  State<WeatherRecommendScreen> createState() =>
      _WeatherRecommendScreenState();
}

class _WeatherRecommendScreenState extends State<WeatherRecommendScreen> {
  bool isLoading = false;
  String weather = "";
  String season = "";
  List<Clothing> recommendations = [];

  Future<void> fetchWeatherRecommendation() async {
    setState(() {
      isLoading = true;
    });

    try {
      final result =
          await WardrobeApiService.getWeatherRecommendation();

      setState(() {
        weather = result["weather"];
        season = result["season"];
        recommendations = result["clothes"];
      });
    } catch (e) {
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Failed to fetch weather outfits")),
      );
    }

    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    fetchWeatherRecommendation();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Weather Recommendation"),
        backgroundColor: const Color(0xFF081A58),
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : Column(
              children: [
                _weatherInfo(),
                Expanded(
                  child: recommendations.isEmpty
                      ? const Center(
                          child: Text("No suitable outfits found"),
                        )
                      : ListView.builder(
                          itemCount: recommendations.length,
                          itemBuilder: (context, index) {
                            return ClothingCard(
                              item: recommendations[index],
                            );
                          },
                        ),
                ),
              ],
            ),
    );
  }

  Widget _weatherInfo() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: const BoxDecoration(
        color: Color(0xFF081A58),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Weather: $weather",
            style: const TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            "Season: $season",
            style: const TextStyle(
              color: Colors.white70,
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }
}
