import 'package:dishlist/core/api_service.dart';
import 'package:dishlist/models/recipe_model.dart';
import 'package:dishlist/widgets/recipe_card.dart';
import 'package:flutter/material.dart';



class SearchScreen extends StatelessWidget {
  final String query;
  const SearchScreen({required this.query});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Results for "$query"')),
      body: FutureBuilder<List<Recipe>>(
        future: ApiService.searchRecipes(query),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No results found.'));
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                final recipe = snapshot.data![index];
                return RecipeCard(recipe: recipe);
              },
            );
          }
        },
      ),
    );
  }
}
