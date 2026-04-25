import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/meal_provider.dart';
import '../widgets/custom_error_view.dart';
import '../widgets/meal_card.dart';
import '../widgets/shimmer_loading.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController searchController = TextEditingController();
  final List<String> categories = ['All', 'Seafood', 'Chicken', 'Dessert', 'Beef'];
  String selectedCategory = 'All';

  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      context.read<MealProvider>().fetchMeals();
    });
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<MealProvider>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Healthy Recipe Explorer'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          if (provider.isOfflineData)
            Container(
              width: double.infinity,
              color: Colors.orange.shade100,
              padding: const EdgeInsets.all(12),
              child: const Text(
                'Mode offline: menampilkan data terakhir yang tersimpan.',
                textAlign: TextAlign.center,
              ),
            ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: TextField(
              controller: searchController,
              decoration: InputDecoration(
                hintText: 'Cari resep...',
                prefixIcon: const Icon(Icons.search),
                suffixIcon: IconButton(
                  icon: const Icon(Icons.send),
                  onPressed: () {
                    context.read<MealProvider>().searchMeals(searchController.text);
                  },
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              onSubmitted: (value) {
                context.read<MealProvider>().searchMeals(value);
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: DropdownButtonFormField<String>(
              value: selectedCategory,
              items: categories
                  .map((category) => DropdownMenuItem(
                        value: category,
                        child: Text(category),
                      ))
                  .toList(),
              onChanged: (value) {
                if (value != null) {
                  setState(() => selectedCategory = value);
                  context.read<MealProvider>().filterMeals(value);
                }
              },
              decoration: InputDecoration(
                labelText: 'Filter kategori',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ),
          const SizedBox(height: 8),
          Expanded(
            child: Builder(
              builder: (_) {
                if (provider.isLoading) {
                  return const ShimmerLoading();
                }

                if (provider.meals.isEmpty && provider.errorMessage.isNotEmpty) {
                  return CustomErrorView(
                    message: provider.errorMessage,
                    onRetry: () => context.read<MealProvider>().fetchMeals(),
                  );
                }

                if (provider.meals.isEmpty) {
                  return CustomErrorView(
                    message: 'Belum ada data untuk ditampilkan.',
                    onRetry: () => context.read<MealProvider>().fetchMeals(),
                  );
                }

                return RefreshIndicator(
                  onRefresh: () => context.read<MealProvider>().fetchMeals(),
                  child: ListView.builder(
                    itemCount: provider.meals.length,
                    itemBuilder: (context, index) {
                      return MealCard(meal: provider.meals[index]);
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}