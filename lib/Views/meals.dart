import 'package:flutter/material.dart';
import 'package:meals/models/meal.dart';
import 'package:meals/widgets/meal_item.dart';

class MealsView extends StatelessWidget {
  const MealsView({
    super.key,
    required this.categoryTitle,
    required this.meals,
  });

  final String categoryTitle;
  final List<Meal> meals;

  @override
  Widget build(BuildContext context) {
    Widget content = Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [Text('No meals available')],
      ),
    );

    if (meals.isNotEmpty) {
      content = ListView.builder(
        itemCount: meals.length,
        itemBuilder: (context, index) => MealItem(meal: meals[index]),
      );
    }

    return Scaffold(appBar: AppBar(title: Text(categoryTitle)), body: content);
  }
}
