
import 'package:flutter/material.dart';
import '../screens/category_screen.dart';

class CategoryGrid extends StatelessWidget {
  const CategoryGrid({super.key});

  final List<Map<String, String>> categories = const [
    {'title': '5 Star Meals', 'emoji': '🌟'},
    {'title': 'African Delights', 'emoji': '🌍'},
    {'title': 'European Adventures', 'emoji': '🇪🇺'},
    {'title': 'Delectable Desserts', 'emoji': '🍰'},
    {'title': 'Quick Bites', 'emoji': '⚡'},
    {'title': 'Healthy Picks', 'emoji': '🥗'},
  ];

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.symmetric(horizontal: 12),
      itemCount: categories.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 10,
        crossAxisSpacing: 10,
        childAspectRatio: 3,
      ),
      itemBuilder: (context, index) {
        final category = categories[index];
        return GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => CategoryScreen(category: category['title']!),
              ),
            );
          },
          child: Container(
            decoration: BoxDecoration(
              color: Colors.orange.shade100,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Center(
              child: Text(
                '${category['emoji']} ${category['title']}',
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
