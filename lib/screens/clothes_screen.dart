import 'package:flutter/material.dart';

class ClothesScreen extends StatefulWidget {
  const ClothesScreen({super.key});

  @override
  State<ClothesScreen> createState() => _ClothesScreenState();
}

class _ClothesScreenState extends State<ClothesScreen>
    with SingleTickerProviderStateMixin {

  late TabController _tabController;

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

  /// PAGE VIEW 1
  Widget _buildAllItems() {
    return const Center(
      child: Text(
        "All items here...",
        style: TextStyle(color: Colors.white70),
      ),
    );
  }

  /// PAGE VIEW 2
  Widget _buildCategories() {
    List<Map<String, dynamic>> categories = [
      {"name": "Tops", "count": 3, "icon": "👚"},
      {"name": "Bottoms", "count": 3, "icon": "👖"},
      {"name": "Jackets", "count": 1, "icon": "🧥"},
      {"name": "Knitwear", "count": 2, "icon": "🧶"},
      {"name": "Shoes", "count": 3, "icon": "👢"},
    ];

    return Container(
      padding: const EdgeInsets.all(16),
      child: ListView(
        children: [
          Row(
            children: [
              const Icon(Icons.add, color: Colors.white),
              const SizedBox(width: 12),
              const Text(
                "Add new category",
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
            ],
          ),

          const SizedBox(height: 20),

          ...categories.map(
            (item) => Container(
              margin: const EdgeInsets.only(bottom: 14),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
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
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
