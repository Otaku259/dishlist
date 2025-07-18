// lib/screens/category_screen.dart
import 'package:flutter/material.dart';
import '../core/api_service.dart';
import '../models/recipe_model.dart';
import '../widgets/recipe_card.dart';

class CategoryScreen extends StatefulWidget {
  final String category;

  const CategoryScreen({super.key, required this.category});

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  late Future<List<Recipe>> _categoryRecipes;

  @override
  void initState() {
    super.initState();
    _categoryRecipes = ApiService.getRecipesByCategory(widget.category);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.category)),
      body: FutureBuilder<List<Recipe>>(
        future: _categoryRecipes,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No recipes found.'));
          } else {
            return ListView.builder(
              padding: const EdgeInsets.all(12),
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                return RecipeCard(recipe: snapshot.data![index]);
              },
            );
          }
        },
      ),
    );
  }
}
