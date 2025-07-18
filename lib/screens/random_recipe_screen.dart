import 'package:flutter/material.dart';
import '../core/api_service.dart';
import '../models/recipe_model.dart';
import '../widgets/recipe_card.dart';

class RandomRecipeScreen extends StatefulWidget {
  const RandomRecipeScreen({super.key});

  @override
  State<RandomRecipeScreen> createState() => _RandomRecipeScreenState();
}

class _RandomRecipeScreenState extends State<RandomRecipeScreen> {
  late Future<Recipe> _randomRecipe;

  @override
  void initState() {
    super.initState();
    _randomRecipe = ApiService.getRandomRecipe();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Surprise Me!')),
      body: FutureBuilder<Recipe>(
        future: _randomRecipe,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData) {
            return const Center(child: Text('No recipe found.'));
          } else {
            return ListView(
              padding: const EdgeInsets.all(12),
              children: [
                RecipeCard(recipe: snapshot.data!),
              ],
            );
          }
        },
      ),
    );
  }
}
