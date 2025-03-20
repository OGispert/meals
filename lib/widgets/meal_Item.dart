import 'package:flutter/material.dart';
import 'package:meals/models/meal.dart';

class MealItem extends StatelessWidget {
  const MealItem({super.key, required this.meal});

  final Meal meal;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Row(
        children: [
          Image.network(meal.imageUrl, width: 120),
          Expanded(
            child: Column(
              children: [
                Text(meal.title),
                Text(meal.affordability.name),
                Text(meal.complexity.name),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
