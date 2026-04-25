import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/meal_model.dart';
import '../utils/constants.dart';

class ApiService {
  Future<List<Meal>> fetchMeals() async {
    final url = Uri.parse('${AppConstants.baseUrl}/search.php?s=');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final List meals = data['meals'] ?? [];
      return meals.map((e) => Meal.fromJson(e)).toList();
    } else {
      throw Exception('Failed to fetch meals');
    }
  }

  Future<List<Meal>> searchMeals(String query) async {
    final url = Uri.parse('${AppConstants.baseUrl}/search.php?s=$query');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final List meals = data['meals'] ?? [];
      return meals.map((e) => Meal.fromJson(e)).toList();
    } else {
      throw Exception('Failed to search meals');
    }
  }

  Future<List<Meal>> filterMealsByCategory(String category) async {
    final url = Uri.parse('${AppConstants.baseUrl}/filter.php?c=$category');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final List meals = data['meals'] ?? [];
      return meals.map((e) {
        return Meal(
          id: e['idMeal'] ?? '',
          name: e['strMeal'] ?? '',
          category: category,
          area: '',
          instructions: '',
          thumbnail: e['strMealThumb'] ?? '',
        );
      }).toList();
    } else {
      throw Exception('Failed to filter meals');
    }
  }
}