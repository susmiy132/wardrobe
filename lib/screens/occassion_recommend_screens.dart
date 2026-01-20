import 'package:flutter/material.dart';
import '../models/clothing_model.dart';
import '../services/wardrobe_api_service.dart';
import '../widgets/clothing_card.dart';

class OccasionRecommendScreen extends StatefulWidget {
  const OccasionRecommendScreen({super.key});

  @override
  State<OccasionRecommendScreen> createState() =>
      _OccasionRecommendScreenState();
}

class _OccasionRecommendScreenState extends State<OccasionRecommendScreen> {
  String selectedOccasion = "Party";
  bool isLoading = false;
  List<Clothing> recommendedClothes = [];

  final List<String> occasions = [
    "College",
    "Party",
    "Office",
    "Wedding",
    "Casual",
  ];

  Future<void> fetchRecommendations() async {
    setState(() {
      isLoading = true;
    });

    try {
      final result =
          await WardrobeApiService.recommendByOccasion(selectedOccasion);
      setState(() {
        recommendedClothes = result;
      });
    } catch (e) {
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Failed to load recommendations")),
      );
    }

    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    fetchRecommendations();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Occasion Recommendation"),
        backgroundColor: const Color(0xFF081A58),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // Occasion Dropdown
            DropdownButtonFormField<String>(
              value: selectedOccasion,
              decoration: const InputDecoration(
                labelText: "Select Occasion",
                border: OutlineInputBorder(),
              ),
              items: occasions
                  .map(
                    (o) => DropdownMenuItem(
                      value: o,
                      child: Text(o),
                    ),
                  )
                  .toList(),
              onChanged: (value) {
                setState(() {
                  selectedOccasion = value!;
                });
              },
            ),

            const SizedBox(height: 16),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: fetchRecommendations,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.pinkAccent,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                ),
                child: const Text(
                  "Get Recommendations",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),

            const SizedBox(height: 20),

            Expanded(
              child: isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : recommendedClothes.isEmpty
                      ? const Center(
                          child: Text("No clothes found for this occasion"),
                        )
                      : ListView.builder(
                          itemCount: recommendedClothes.length,
                          itemBuilder: (context, index) {
                            return ClothingCard(
                              item: recommendedClothes[index],
                            );
                          },
                        ),
            ),
          ],
        ),
      ),
    );
  }
}
