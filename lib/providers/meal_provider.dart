import 'package:flutter/material.dart';
import '../models/meal_model.dart';
import '../services/api_service.dart';
import '../services/cache_service.dart';

class MealProvider extends ChangeNotifier {
  final ApiService apiService = ApiService();
  final CacheService cacheService = CacheService();

  List<Meal> meals = [];
  bool isLoading = false;
  String errorMessage = '';
  bool isOfflineData = false;

  Future<void> fetchMeals() async {
    isLoading = true;
    errorMessage = '';
    isOfflineData = false;
    notifyListeners();

    try {
      final fetchedMeals = await apiService.fetchMeals();
      meals = fetchedMeals;
      await cacheService.saveMeals(fetchedMeals);
    } catch (e) {
      final cachedMeals = await cacheService.getCachedMeals();
      if (cachedMeals.isNotEmpty) {
        meals = cachedMeals;
        isOfflineData = true;
        errorMessage = 'Kamu sedang offline. Menampilkan data terakhir yang tersimpan.';
      } else {
        errorMessage = 'Gagal mengambil data. Coba lagi beberapa saat.';
      }
    }

    isLoading = false;
    notifyListeners();
  }

  Future<void> searchMeals(String query) async {
    isLoading = true;
    errorMessage = '';
    notifyListeners();

    try {
      if (query.trim().isEmpty) {
        await fetchMeals();
        return;
      }

      meals = await apiService.searchMeals(query);
      if (meals.isEmpty) {
        errorMessage = 'Resep tidak ditemukan. Coba kata kunci lain.';
      }
    } catch (e) {
      errorMessage = 'Pencarian gagal. Periksa koneksi lalu coba lagi.';
    }

    isLoading = false;
    notifyListeners();
  }

  Future<void> filterMeals(String category) async {
    isLoading = true;
    errorMessage = '';
    notifyListeners();

    try {
      if (category == 'All') {
        await fetchMeals();
        return;
      }

      meals = await apiService.filterMealsByCategory(category);
      if (meals.isEmpty) {
        errorMessage = 'Tidak ada resep dalam kategori ini.';
      }
    } catch (e) {
      errorMessage = 'Filter gagal dijalankan.';
    }

    isLoading = false;
    notifyListeners();
  }
}