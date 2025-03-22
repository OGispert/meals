import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals/providers/filters_provider.dart';

class FiltersView extends ConsumerWidget {
  const FiltersView({super.key});

  Widget toggle(
    BuildContext context,
    WidgetRef ref,
    int id,
    bool value,
    String title,
    String subtitle,
  ) {
    return SwitchListTile.adaptive(
      value: value,
      onChanged: (isOn) {
        switch (id) {
          case 1:
            ref
                .read(filtersProvider.notifier)
                .setFilter(Filter.glutenFree, isOn);
          case 2:
            ref
                .read(filtersProvider.notifier)
                .setFilter(Filter.lactoseFree, isOn);
          case 3:
            ref
                .read(filtersProvider.notifier)
                .setFilter(Filter.vegetarian, isOn);
          case 4:
            ref.read(filtersProvider.notifier).setFilter(Filter.vegan, isOn);
        }
      },
      title: Text(
        title,
        style: Theme.of(context).textTheme.titleLarge?.copyWith(
          color: Theme.of(context).colorScheme.onSurface,
        ),
      ),
      subtitle: Text(
        subtitle,
        style: Theme.of(context).textTheme.labelMedium?.copyWith(
          color: Theme.of(context).colorScheme.onSurface,
        ),
      ),
      contentPadding: EdgeInsets.only(left: 34, right: 22),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final activeFilters = ref.watch(filtersProvider);

    return Scaffold(
      appBar: AppBar(title: Text('Filters')),
      body: Column(
        children: [
          SizedBox(height: 18),
          toggle(
            context,
            ref,
            1,
            activeFilters[Filter.glutenFree] ?? false,
            'Gluten-free',
            'Only include gluten-free meals.',
          ),
          toggle(
            context,
            ref,
            2,
            activeFilters[Filter.lactoseFree] ?? false,
            'Lactose-free',
            'Only include lactose-free meals.',
          ),
          toggle(
            context,
            ref,
            3,
            activeFilters[Filter.vegetarian] ?? false,
            'Vegetarian',
            'Only include vegetarian meals.',
          ),
          toggle(
            context,
            ref,
            4,
            activeFilters[Filter.vegan] ?? false,
            'Vegan',
            'Only include vegan meals.',
          ),
        ],
      ),
    );
  }
}
