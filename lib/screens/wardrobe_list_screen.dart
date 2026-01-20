// import 'package:flutter/material.dart';
// import 'package:personal_wardrobe/models/clothing_model.dart';
// import 'package:personal_wardrobe/services/wardrobe_api_service.dart';

// class WardrobeListScreen extends StatelessWidget {
//   const WardrobeListScreen({super.key});

//   @override
//   State<WardrobeListScreen> createState() => _WardrobeListScreenState();
  
//   @override
//   Widget build(Object context) {
//     throw UnimplementedError();
//   }

// }

// class _WardrobeListScreenState extends State<WardrobeListScreen>{

//   late Future<List<Clothing>> clothes;

//   @override
//   void initState() {
//     super.initState();
//     clothes = WardrobeApiService.fetchClothes();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return const Placeholder();
//   }
// }




// import 'package:flutter/material.dart';
// import '../services/wardrobe_api_service.dart';
// import '../widgets/clothing_card.dart';
// import '../models/clothing_model.dart';
// import 'add_clothing_screen.dart';

// class WardrobeListScreen extends StatefulWidget {
//   const WardrobeListScreen({super.key});

//   @override
//   State<WardrobeListScreen> createState() => _WardrobeListScreenState();
// }

// class _WardrobeListScreenState extends State<WardrobeListScreen> {
//   late Future<List<Clothing>> clothes;

//   @override
//   void initState() {
//     super.initState();
//     clothes = WardrobeApiService.fetchClothes();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("My Wardrobe"),
//       ),
//       floatingActionButton: FloatingActionButton(
//         child: const Icon(Icons.add),
//         onPressed: () async {
//           await Navigator.push(
//             context,
//             MaterialPageRoute(builder: (_) => const AddClothingScreen()),
//           );
//           setState(() {
//             clothes = WardrobeApiService.fetchClothes();
//           });
//         },
//       ),
//       body: FutureBuilder(
//         future: clothes,
//         builder: (context, snapshot) {
//           if (!snapshot.hasData) {
//             return const Center(child: CircularProgressIndicator());
//           }
//           return ListView(
//             children: snapshot.data!
//                 .map((e) => ClothingCard(item: e))
//                 .toList(),
//           );
//         },
//       ),
//     );
//   }
// }



import 'package:flutter/material.dart';
import 'package:personal_wardrobe/screens/ai_recommend_screen.dart';
import 'package:personal_wardrobe/screens/occassion_recommend_screens.dart';
import 'package:personal_wardrobe/screens/weather_recommend_screens.dart';
import '../models/clothing_model.dart';
import '../services/wardrobe_api_service.dart';
import '../widgets/clothing_card.dart';
import 'add_clothing_screen.dart';

class WardrobeListScreen extends StatefulWidget {
  const WardrobeListScreen({super.key});

  @override
  State<WardrobeListScreen> createState() => _WardrobeListScreenState();
}

class _WardrobeListScreenState extends State<WardrobeListScreen> {
  List<Clothing> clothes = [];
  bool isLoading = false;

  Future<void> loadClothes() async {
    setState(() {
      isLoading = true;
    });

    try {
      final result = await WardrobeApiService.getAllClothes();
      setState(() {
        clothes = result;
      });
    } catch (e) {
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Failed to load wardrobe")),
      );
    }

    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    loadClothes();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("My Wardrobe"),
        backgroundColor: const Color(0xFF081A58),

        // 🔽 THIS IS WHERE YOUR CODE GOES
        actions: [
          IconButton(
            icon: const Icon(Icons.event),
            tooltip: "Occasion Recommendation",
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const OccasionRecommendScreen(),
                ),
              );
            },
          ),

          IconButton(
            icon: const Icon(Icons.cloud),
            tooltip: "Weather Recommendation",
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const WeatherRecommendScreen(),
                ),
              );
            },
          ),

          IconButton(
            icon: const Icon(Icons.auto_awesome),
            tooltip: "AI Recommend",
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const AiRecommendScreen(),
                ),
              );
            },
          )

        ],
      ),

      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : clothes.isEmpty
              ? const Center(child: Text("No clothes added yet"))
              : ListView.builder(
                  itemCount: clothes.length,
                  itemBuilder: (context, index) {
                    return ClothingCard(item: clothes[index]);
                  },
                ),

      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.pinkAccent,
        child: const Icon(Icons.add),
        onPressed: () async {
          await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => const AddClothingScreen(),
            ),
          );
          loadClothes(); // refresh after adding
        },
      ),
    );
  }
}
