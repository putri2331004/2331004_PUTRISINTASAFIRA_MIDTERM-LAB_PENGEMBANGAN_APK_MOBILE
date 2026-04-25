import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/meal_provider.dart';
import 'views/home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => MealProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Healthy Recipe Explorer',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.orange),
          useMaterial3: true,
        ),
        home: const HomePage(),
      ),
    );
  }
}