import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/meal_model.dart';
import '../utils/constants.dart';

class CacheService {
  Future<void> saveMeals(List<Meal> meals) async {
    final prefs = await SharedPreferences.getInstance();
    final mealsJson = meals.map((meal) => meal.toJson()).toList();
    await prefs.setString(AppConstants.cacheKeyMeals, jsonEncode(mealsJson));
  }

  Future<List<Meal>> getCachedMeals() async {
    final prefs = await SharedPreferences.getInstance();
    final cachedData = prefs.getString(AppConstants.cacheKeyMeals);

    if (cachedData == null) return [];

    final List decoded = jsonDecode(cachedData);
    return decoded.map((e) => Meal.fromJson(e)).toList();
  }
}