import 'package:flutter/material.dart';
import 'package:personal_wardrobe/models/clothing_model.dart';

class ClothingCard extends StatelessWidget {
  final Clothing item;

  const ClothingCard({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: Image.network(
          "http://10.0.2.2:3000/${item.image}",
          width:50,
          fit: BoxFit.cover,
        ),
        title: Text(item.name),
        subtitle: Text("${item.category} . ${item.occasion}"),
      ),
    );
  }
}