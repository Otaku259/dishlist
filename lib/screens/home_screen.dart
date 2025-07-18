import 'package:flutter/material.dart';
import '../core/api_service.dart';
import '../models/recipe_model.dart';
import '../widgets/search_bar.dart';
import '../widgets/recipe_carousel.dart';
import '../widgets/category_grid.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Future<List<Recipe>> _trendingRecipes;

  @override
  void initState() {
    super.initState();
    _trendingRecipes = ApiService.getTrendingRecipes();
  }

  void _goToRandomRecipe() async {
    try {
      final randomRecipes = await ApiService.getTrendingRecipes();
      if (randomRecipes.isNotEmpty) {
        final randomRecipe = (randomRecipes..shuffle()).first;
        // Navigate to recipe details page or show details here
        // For example: Navigator.pushNamed(context, '/recipeDetails', arguments: randomRecipe.id);
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to load a random recipe.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100], // Soft neutral background
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          'DishList 🍽️',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppSearchBar(),
            const SizedBox(height: 10),
            FutureBuilder<List<Recipe>>(
              future: _trendingRecipes,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Center(child: Text('No trendy dishes found.'));
                } else {
                  return RecipeCarousel(recipes: snapshot.data!);
                }
              },
            ),
            const Padding(
              padding: EdgeInsets.all(12.0),
              child: Text(
                'Explore by Category',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            const CategoryGrid(),
            const SizedBox(height: 20),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _goToRandomRecipe,
        label: const Text("Surprise Me!"),
        icon: const Icon(Icons.casino),
        backgroundColor: Colors.deepOrange,
      ),
    );
  }
}
