class Recipe {
  final int id;
  final String title;
  final String imageUrl;
  final String? summary;
  final List<String> ingredients;
  final String? instructions;

  Recipe({
    required this.id,
    required this.title,
    required this.imageUrl,
    this.summary,
    required this.ingredients,
    this.instructions,
  });

  factory Recipe.fromJson(Map<String, dynamic> json) {
    return Recipe(
      id: json['id'],
      title: json['title'],
      imageUrl: json['image'] ?? '',
      summary: json['summary'] ?? '',
      ingredients: (json['extendedIngredients'] != null)
          ? List<String>.from(
              json['extendedIngredients'].map((ing) => ing['original']).toList())
          : [],
      instructions: json['instructions'] ?? '',
    );
  }
}
