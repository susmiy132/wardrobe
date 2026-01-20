import 'package:flutter/material.dart';

class AccountScreen extends StatelessWidget {
  const AccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF081A58),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "My account",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 30),

              _menuItem(Icons.add_box_outlined, "Add new item"),
              _menuItem(Icons.brush_outlined, "Add new look"),
              _menuItem(Icons.favorite_border, "Wishlist"),
              _menuItem(Icons.shopping_cart_outlined, "Shopping"),
              _menuItem(Icons.straighten, "Size tracker"),
              _menuItem(Icons.search, "Search"),
              _menuItem(Icons.settings, "Account settings"),

              const Spacer(),

              Divider(color: Colors.white38),

              _menuItem(Icons.delete_outline, "Trash can"),
              _menuItem(Icons.logout, "Sign out"),
            ],
          ),
        ),
      ),
    );
  }

  Widget _menuItem(IconData icon, String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Row(
        children: [
          Icon(icon, color: Colors.white70),
          const SizedBox(width: 16),
          Text(
            title,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 16,
            ),
          )
        ],
      ),
    );
  }
}
