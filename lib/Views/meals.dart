import 'package:flutter/material.dart';
import 'package:meals/views/meal_details.dart';
import 'package:meals/models/meal.dart';
import 'package:meals/widgets/meal_item.dart';

class MealsView extends StatelessWidget {
  const MealsView({super.key, this.categoryTitle, required this.meals});

  final String? categoryTitle;
  final List<Meal> meals;

  void _selectMeal(BuildContext context, Meal meal) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (cntext) => MealDetailsView(meal: meal)),
    );
  }

  @override
  Widget build(BuildContext context) {
    Widget content = Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('0.o', style: TextStyle(color: Colors.white, fontSize: 18)),
          Text(
            'There is nothing to show here.',
            style: TextStyle(color: Colors.white, fontSize: 16),
          ),
        ],
      ),
    );

    if (meals.isNotEmpty) {
      content = ListView.builder(
        itemCount: meals.length,
        itemBuilder:
            (context, index) => InkWell(
              child: MealItem(
                meal: meals[index],
                onMealSelected: () {
                  _selectMeal(context, meals[index]);
                },
              ),
            ),
      );
    }
    if (categoryTitle == null) {
      return content;
    }
    return Scaffold(
      appBar: AppBar(title: Text(categoryTitle ?? '')),
      body: content,
    );
  }
}
