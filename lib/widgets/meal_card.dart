import 'package:flutter/material.dart';
import '../models/meal_model.dart';
import '../views/detail_page.dart';

class MealCard extends StatelessWidget {
  final Meal meal;

  const MealCard({super.key, required this.meal});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      elevation: 3,
      child: ListTile(
        leading: ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Image.network(
            meal.thumbnail,
            width: 60,
            height: 60,
            fit: BoxFit.cover,
            errorBuilder: (_, __, ___) => const Icon(Icons.broken_image),
          ),
        ),
        title: Text(meal.name),
        subtitle: Text(
          meal.category.isEmpty ? 'Kategori tidak tersedia' : meal.category,
        ),
        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => DetailPage(meal: meal),
            ),
          );
        },
      ),
    );
  }
}