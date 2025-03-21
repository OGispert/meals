import 'package:flutter/material.dart';
import 'package:meals/models/meal.dart';
import 'package:transparent_image/transparent_image.dart';

class MealItem extends StatelessWidget {
  const MealItem({super.key, required this.meal, required this.onMealSelected});

  final Meal meal;
  final void Function() onMealSelected;

  @override
  Widget build(BuildContext context) {
    Widget metaRow(IconData icon, String label) {
      return Row(
        children: [
          Icon(icon, size: 17, color: Colors.white),
          SizedBox(width: 6),
          Text(label, style: TextStyle(color: Colors.white)),
        ],
      );
    }

    return Card(
      margin: EdgeInsets.all(8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      clipBehavior: Clip.hardEdge,
      elevation: 2.0,
      child: InkWell(
        onTap: onMealSelected,
        child: Stack(
          children: [
            FadeInImage(
              placeholder: MemoryImage(kTransparentImage),
              image: NetworkImage(meal.imageUrl),
              fit: BoxFit.cover,
              height: 200,
              width: double.infinity,
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                color: Colors.black54,
                padding: EdgeInsets.symmetric(vertical: 6, horizontal: 44),
                child: Column(
                  children: [
                    Text(
                      meal.title,
                      maxLines: 2,
                      textAlign: TextAlign.center,
                      softWrap: true,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 12),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        metaRow(Icons.schedule, '${meal.duration} min.'),
                        SizedBox(width: 12),
                        metaRow(Icons.work, meal.complexity.name),
                        SizedBox(width: 12),
                        metaRow(Icons.attach_money, meal.affordability.name),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
