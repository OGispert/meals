import 'package:flutter/material.dart';
import 'package:meals/models/meal.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals/providers/favorites_provider.dart';

class MealDetailsView extends ConsumerStatefulWidget {
  const MealDetailsView({super.key, required this.meal});

  final Meal meal;

  @override
  ConsumerState<MealDetailsView> createState() {
    return _MealDetailsViewState();
  }
}

class _MealDetailsViewState extends ConsumerState<MealDetailsView> {
  @override
  Widget build(BuildContext context) {
    bool isFavorite = ref
        .watch(favoriteMealsProvider.notifier)
        .isFavorite(widget.meal);

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.meal.title),
        actions: [
          IconButton(
            onPressed: () {
              final favoriteState = ref
                  .read(favoriteMealsProvider.notifier)
                  .toggleMealFavoriteState(widget.meal);

              setState(() {
                isFavorite = favoriteState;
              });
            },
            icon:
                isFavorite ? Icon(Icons.favorite) : Icon(Icons.favorite_border),
          ),
        ],
      ),
      body: ListView(
        children: [
          FadeInImage(
            placeholder: MemoryImage(kTransparentImage),
            image: NetworkImage(widget.meal.imageUrl),
            fit: BoxFit.cover,
            height: 200,
            width: double.infinity,
          ),
          SizedBox(height: 16),
          Text(
            'Ingredients',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
              color: Theme.of(context).colorScheme.primary,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 12),
          for (final ingredient in widget.meal.ingredients)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                ingredient,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Theme.of(context).colorScheme.onSurface,
                ),
              ),
            ),
          SizedBox(height: 24),
          Text(
            'Steps',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
              color: Theme.of(context).colorScheme.primary,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 12),
          for (final step in widget.meal.steps)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              child: Text(
                step,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Theme.of(context).colorScheme.onSurface,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
