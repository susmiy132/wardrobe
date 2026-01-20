// import 'package:flutter/material.dart';

// class ClothesScreen extends StatefulWidget {
//   const ClothesScreen({super.key});

//   @override
//   State<ClothesScreen> createState() => _ClothesScreenState();
// }

// class _ClothesScreenState extends State<ClothesScreen>
//     with SingleTickerProviderStateMixin {

//   late TabController _tabController;

//   @override
//   void initState() {
//     super.initState();
//     _tabController = TabController(length: 2, vsync: this);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: const Color(0xFF081A58),
//       appBar: AppBar(
//         backgroundColor: const Color(0xFF081A58),
//         elevation: 0,
//         title: const Text(
//           "Clothes",
//           style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
//         ),
//         actions: [
//           TextButton(
//             onPressed: () {},
//             child: const Text(
//               "Edit",
//               style: TextStyle(color: Colors.white, fontSize: 16),
//             ),
//           )
//         ],
//       ),

//       body: Column(
//         children: [
//           Container(
//             height: 48,
//             padding: const EdgeInsets.symmetric(horizontal: 16),
//             child: TabBar(
//               controller: _tabController,
//               indicatorColor: Colors.pinkAccent,
//               labelColor: Colors.white,
//               unselectedLabelColor: Colors.white54,
//               tabs: const [
//                 Tab(text: "All items"),
//                 Tab(text: "Categories"),
//               ],
//             ),
//           ),

//           Expanded(
//             child: TabBarView(
//               controller: _tabController,
//               children: [
//                 _buildAllItems(),
//                 _buildCategories(),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   /// PAGE VIEW 1
//   Widget _buildAllItems() {
//     return const Center(
//       child: Text(
//         "All items here...",
//         style: TextStyle(color: Colors.white70),
//       ),
//     );
//   }

//   /// PAGE VIEW 2
//   Widget _buildCategories() {
//     List<Map<String, dynamic>> categories = [
//       {"name": "Tops", "count": 3, "icon": "👚"},
//       {"name": "Bottoms", "count": 3, "icon": "👖"},
//       {"name": "Jackets", "count": 1, "icon": "🧥"},
//       {"name": "Knitwear", "count": 2, "icon": "🧶"},
//       {"name": "Shoes", "count": 3, "icon": "👢"},
//     ];

//     return Container(
//       padding: const EdgeInsets.all(16),
//       child: ListView(
//         children: [
//           Row(
//             children: [
//               const Icon(Icons.add, color: Colors.white),
//               const SizedBox(width: 12),
//               const Text(
//                 "Add new category",
//                 style: TextStyle(color: Colors.white, fontSize: 16),
//               ),
//             ],
//           ),

//           const SizedBox(height: 20),

//           ...categories.map(
//             (item) => Container(
//               margin: const EdgeInsets.only(bottom: 14),
//               padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
//               decoration: BoxDecoration(
//                 color: const Color(0xFF0D1D6A),
//                 borderRadius: BorderRadius.circular(12),
//               ),
//               child: Row(
//                 children: [
//                   Text(
//                     item["icon"],
//                     style: const TextStyle(fontSize: 26),
//                   ),
//                   const SizedBox(width: 16),
//                   Text(
//                     item["name"],
//                     style: const TextStyle(
//                       color: Colors.white,
//                       fontSize: 16,
//                     ),
//                   ),
//                   const Spacer(),
//                   Text(
//                     "${item["count"]} items",
//                     style: const TextStyle(
//                       color: Colors.white70,
//                       fontSize: 14,
//                     ),
//                   )
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }



import 'package:flutter/material.dart';
import 'package:personal_wardrobe/screens/add_category_screen.dart';
import 'package:personal_wardrobe/screens/wardrobe_list_screen.dart';

class ClothesScreen extends StatefulWidget {
  const ClothesScreen({super.key});

  @override
  State<ClothesScreen> createState() => _ClothesScreenState();
}

class _ClothesScreenState extends State<ClothesScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  // TEMP DATA – later replace with backend response
  bool hasClothes = false;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF081A58),
      appBar: AppBar(
        backgroundColor: const Color(0xFF081A58),
        elevation: 0,
        title: const Text(
          "Clothes",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        actions: [
          TextButton(
            onPressed: () {},
            child: const Text(
              "Edit",
              style: TextStyle(color: Colors.white, fontSize: 16),
            ),
          )
        ],
      ),
      body: Column(
        children: [
          Container(
            height: 48,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: TabBar(
              controller: _tabController,
              indicatorColor: Colors.pinkAccent,
              labelColor: Colors.white,
              unselectedLabelColor: Colors.white54,
              tabs: const [
                Tab(text: "All items"),
                Tab(text: "Categories"),
              ],
            ),
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                _buildAllItems(),
                _buildCategories(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // =========================
  // PAGE VIEW 1 – ALL ITEMS
  // =========================
  Widget _buildAllItems() {
    // TEMP: no clothes added yet
  if (!hasClothes) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.checkroom,
            size: 70,
            color: Colors.white54,
          ),
          const SizedBox(height: 16),
          const Text(
            "No clothes added yet",
            style: TextStyle(
              color: Colors.white70,
              fontSize: 18,
            ),
          ),
          const SizedBox(height: 30),

          // ===============================
          // YOUR WARDROBE BUTTON
          // ===============================
          SizedBox(
            width: 180,
            height: 50,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.pinkAccent,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              onPressed: () {
                // Navigate to WardrobeListScreen
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const WardrobeListScreen(), 
                  ),
                );
              },
              child: const Text(
                "Your Wardrobe",
                style: TextStyle(fontSize: 16, color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }

    // When clothes exist (grid view)
    return GridView.builder(
      padding: const EdgeInsets.all(16),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
      ),
      itemCount: 6,
      itemBuilder: (context, index) {
        return Container(
          decoration: BoxDecoration(
            color: const Color(0xFF0D1D6A),
            borderRadius: BorderRadius.circular(12),
          ),
          child: const Center(
            child: Text(
              "Clothing Item",
              style: TextStyle(color: Colors.white),
            ),
          ),
        );
      },
    );
  }

  // =========================
  // PAGE VIEW 2 – CATEGORIES
  // =========================
  Widget _buildCategories() {
    List<Map<String, dynamic>> categories = [
      {"name": "Tops", "count": 3, "icon": "👚"},
      {"name": "Bottoms", "count": 3, "icon": "👖"},
      {"name": "Jackets", "count": 1, "icon": "🧥"},
      {"name": "Knitwear", "count": 2, "icon": "🧶"},
      {"name": "Shoes", "count": 3, "icon": "👢"},
    ];

    return Padding(
      padding: const EdgeInsets.all(16),
      child: ListView(
        children: [

          /// ADD CATEGORY BUTTON
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const AddCategoryScreen(),
                ),
              );
            },
            child: Row(
              children: const [
                Icon(Icons.add, color: Colors.white),
                SizedBox(width: 12),
                Text(
                  "Add new category",
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          ...categories.map(
            (item) => Container(
              margin: const EdgeInsets.only(bottom: 14),
              padding:
                  const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
              decoration: BoxDecoration(
                color: const Color(0xFF0D1D6A),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  Text(
                    item["icon"],
                    style: const TextStyle(fontSize: 26),
                  ),
                  const SizedBox(width: 16),
                  Text(
                    item["name"],
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                  const Spacer(),
                  Text(
                    "${item["count"]} items",
                    style: const TextStyle(
                      color: Colors.white70,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
