import 'dart:io';
import 'package:flutter/material.dart';
import '../services/wardrobe_api_service.dart';
import '../utils/image_picker_helper.dart';

class AddClothingScreen extends StatefulWidget {
  const AddClothingScreen({super.key});

  @override
  State<AddClothingScreen> createState() => _AddClothingScreenState();
}

class _AddClothingScreenState extends State<AddClothingScreen> {
  final Map<String, String> data = {};
  File? image;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Add Clothing")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(onChanged: (v) => data['name'] = v, decoration: const InputDecoration(labelText: "Name")),
            TextField(onChanged: (v) => data['category'] = v, decoration: const InputDecoration(labelText: "Category")),
            TextField(onChanged: (v) => data['color'] = v, decoration: const InputDecoration(labelText: "Color")),
            TextField(onChanged: (v) => data['season'] = v, decoration: const InputDecoration(labelText: "Season")),
            TextField(onChanged: (v) => data['occasion'] = v, decoration: const InputDecoration(labelText: "Occasion")),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () async {
                image = await ImagePickerHelper.pickImage();
              },
              child: const Text("Pick Image"),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                if (image != null) {
                  await WardrobeApiService.addClothing(image!, data);
                  // ignore: use_build_context_synchronously
                  Navigator.pop(context);
                }
              },
              child: const Text("Save"),
            ),
          ],
        ),
      ),
    );
  }
}
