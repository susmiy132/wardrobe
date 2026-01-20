import 'package:flutter/material.dart';
import '../models/clothing_model.dart';
import '../services/wardrobe_api_service.dart';
import '../widgets/clothing_card.dart';

class AiRecommendScreen extends StatefulWidget {
  const AiRecommendScreen({super.key});

  @override
  State<AiRecommendScreen> createState() => _AiRecommendScreenState();
}

class _AiRecommendScreenState extends State<AiRecommendScreen> {
  bool isLoading = false;
  String occasion = "";
  String season = "";
  String weather = "";
  List<Clothing> outfits = [];

  Future<void> fetchAiRecommendation() async {
    setState(() => isLoading = true);

    try {
      final result =
          await WardrobeApiService.getAiRecommendation();

      setState(() {
        occasion = result["occasion"];
        season = result["season"];
        weather = result["weather"];
        outfits = result["outfits"];
      });
    } catch (e) {
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("AI recommendation failed")),
      );
    }

    setState(() => isLoading = false);
  }

  @override
  void initState() {
    super.initState();
    fetchAiRecommendation();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("AI Outfit Recommendation"),
        backgroundColor: const Color(0xFF081A58),
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : Column(
              children: [
                _aiInfo(),
                Expanded(
                  child: outfits.isEmpty
                      ? const Center(
                          child: Text("No AI outfits found"),
                        )
                      : ListView.builder(
                          itemCount: outfits.length,
                          itemBuilder: (context, index) {
                            return ClothingCard(item: outfits[index]);
                          },
                        ),
                ),
              ],
            ),
    );
  }

  Widget _aiInfo() {
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
            "Occasion: $occasion",
            style: const TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            "Weather: $weather",
            style: const TextStyle(color: Colors.white70),
          ),
          Text(
            "Season: $season",
            style: const TextStyle(color: Colors.white70),
          ),
        ],
      ),
    );
  }
}
