import 'package:flutter/material.dart';
import '../models/meal_model.dart';

class DetailPage extends StatelessWidget {
  final Meal meal;

  const DetailPage({super.key, required this.meal});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(meal.name),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(
              meal.thumbnail,
              width: double.infinity,
              height: 240,
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) => Container(
                height: 240,
                color: Colors.grey.shade300,
                child: const Center(child: Icon(Icons.broken_image)),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Text(
                meal.name,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text('Kategori: ${meal.category.isEmpty ? '-' : meal.category}'),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Text('Area: ${meal.area.isEmpty ? '-' : meal.area}'),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Text(
                meal.instructions.isEmpty
                    ? 'Instruksi belum tersedia untuk item ini.'
                    : meal.instructions,
              ),
            ),
          ],
        ),
      ),
    );
  }
}