import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:dishlist/models/recipe_model.dart';

class ApiService {
  static const String _apiKey = 'c54f9a53ed8049f493fd26b2a3e206ec';
  static const String _baseUrl = 'https://api.spoonacular.com/recipes';

  static Future<List<Recipe>> getTrendingRecipes() async {
    final response = await http.get(
      Uri.parse('$_baseUrl/random?number=10&apiKey=$_apiKey'),
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      List recipes = data['recipes'];
      return recipes.map((json) => Recipe.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load trending recipes');
    }
  }

  static Future<List<Recipe>> searchRecipes(String query) async {
    final response = await http.get(Uri.parse(
      '$_baseUrl/complexSearch?query=$query&number=10&addRecipeInformation=true&apiKey=$_apiKey',
    ));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      List recipes = data['results'];
      return recipes.map((json) => Recipe.fromJson(json)).toList();
    } else {
      throw Exception('Failed to search recipes');
    }
  }

  static Future<Recipe> getRecipeDetails(int id) async {
    final response = await http.get(
      Uri.parse('$_baseUrl/$id/information?apiKey=$_apiKey'),
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return Recipe.fromJson(data);
    } else {
      throw Exception('Failed to load recipe details');
    }
  }

  static Future<List<Recipe>> getRecipesByCategory(String category) async {
    final response = await http.get(Uri.parse(
      '$_baseUrl/complexSearch?query=$category&number=10&addRecipeInformation=true&apiKey=$_apiKey',
    ));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      List recipes = data['results'];
      return recipes.map((json) => Recipe.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load recipes for $category');
    }
  }

  static Future<Recipe> getRandomRecipe() async {
    final response = await http.get(
      Uri.parse('$_baseUrl/random?number=1&apiKey=$_apiKey'),
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return Recipe.fromJson(data['recipes'][0]);
    } else {
      throw Exception('Failed to fetch a random recipe');
    }
  }
}
