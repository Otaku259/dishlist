import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import '../models/recipe_model.dart';
import 'recipe_card.dart';

class RecipeCarousel extends StatelessWidget {
  final List<Recipe> recipes;

  const RecipeCarousel({super.key, required this.recipes});

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      options: CarouselOptions(
        height: 250,
        enlargeCenterPage: true,
        autoPlay: true,
        autoPlayInterval: const Duration(seconds: 3),
        viewportFraction: 0.8,
      ),
      items: recipes.map((recipe) {
        return Builder(
          builder: (BuildContext context) {
            return RecipeCard(recipe: recipe);
          },
        );
      }).toList(),
    );
  }
}
