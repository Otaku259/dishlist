import 'package:dishlist/core/api_service.dart';
import 'package:dishlist/models/recipe_model.dart';
import 'package:flutter/material.dart';

class DetailScreen extends StatelessWidget {
  final int recipeId;
  const DetailScreen({super.key, required this.recipeId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Recipe Details')),
      body: FutureBuilder<Recipe>(
        future: ApiService.getRecipeDetails(recipeId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData) {
            return const Center(child: Text('No details found.'));
          } else {
            final recipe = snapshot.data!;
            return SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.network(recipe.imageUrl),
                  const SizedBox(height: 12),
                  Text(recipe.title, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 16),
                  const Text('📝 Ingredients:', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 6),
                  ...recipe.ingredients.map((ing) => Text("• $ing")),
                  const SizedBox(height: 16),
                  const Text('👨‍🍳 Instructions:', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 6),
                  Text(recipe.instructions ?? 'No instructions provided.'),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
