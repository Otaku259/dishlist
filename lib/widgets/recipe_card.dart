import 'package:dishlist/models/recipe_model.dart';
import 'package:dishlist/screens/detail_screen.dart';
import 'package:flutter/material.dart';


class RecipeCard extends StatelessWidget {
  final Recipe recipe;
  const RecipeCard({required this.recipe});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(context,
          MaterialPageRoute(builder: (_) => DetailScreen(recipeId: recipe.id)));
      },
      child: Card(
        margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        elevation: 4,
        child: Row(
          children: [
            Image.network(
              recipe.imageUrl,
              width: 100,
              height: 100,
              fit: BoxFit.cover,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                recipe.title,
                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
