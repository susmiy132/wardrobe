import 'dart:async';
import 'package:flutter/material.dart';
import 'package:personal_wardrobe/screens/dashboard_screens.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {

  @override
  void initState() {
    super.initState();

    // Navigate to wardrobe after 5 seconds
    Timer(const Duration(seconds: 5), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => const DashboardScreen(),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFE3E3),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            // 🖼️ TOP IMAGE
            Image.asset(
              'assets/images/wardrobe.png',
              height: 220,
            ),

            const SizedBox(height: 30),

            // 👗 TITLE
            const Text(
              "Welcome to Wardrobe",
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                color: Color(0xFF0A1340),
              ),
            ),

            const SizedBox(height: 12),

            // ✨ SUBTITLE
            const Text(
              "Your personal digital closet",
              style: TextStyle(
                fontSize: 16,
                color: Colors.black54,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
