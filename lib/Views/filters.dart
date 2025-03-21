import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:meals/Views/tabs.dart';
// import 'package:meals/widgets/main_drawer.dart';
import 'package:meals/providers/filters_provider.dart';

class FiltersView extends ConsumerStatefulWidget {
  const FiltersView({super.key});

  @override
  ConsumerState<FiltersView> createState() {
    return _FiltersViewState();
  }
}

class _FiltersViewState extends ConsumerState<FiltersView> {
  var glutenFreeFilterSet = false;
  var lactoseFreeFilterSet = false;
  var vegetarianFilterSet = false;
  var veganFilterSet = false;

  @override
  void initState() {
    super.initState();
    final activeFilters = ref.read(filtersProvider);
    glutenFreeFilterSet = activeFilters[Filter.glutenFree] ?? false;
    lactoseFreeFilterSet = activeFilters[Filter.lactoseFree] ?? false;
    vegetarianFilterSet = activeFilters[Filter.vegetarian] ?? false;
    veganFilterSet = activeFilters[Filter.vegan] ?? false;
  }

  Widget toggle(int id, bool value, String title, String subtitle) {
    return SwitchListTile.adaptive(
      value: value,
      onChanged: (isOn) {
        setState(() {
          switch (id) {
            case 1:
              glutenFreeFilterSet = isOn;
            case 2:
              lactoseFreeFilterSet = isOn;
            case 3:
              vegetarianFilterSet = isOn;
            case 4:
              veganFilterSet = isOn;
          }
        });
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
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Filters')),
      // drawer: MainDrawer(
      //   onSelectScreen: (identifier) {
      //     Navigator.of(context).pop();
      //     if (identifier == 'meals') {
      //       Navigator.of(context).pushReplacement(
      //         MaterialPageRoute(builder: (context) => TabsView()),
      //       );
      //     }
      //   },
      // ),
      body: PopScope(
        canPop: true,
        onPopInvokedWithResult: (didPop, result) {
          ref.read(filtersProvider.notifier).setAllFilters({
            Filter.glutenFree: glutenFreeFilterSet,
            Filter.lactoseFree: lactoseFreeFilterSet,
            Filter.vegetarian: vegetarianFilterSet,
            Filter.vegan: veganFilterSet,
          });
        },
        child: Column(
          children: [
            SizedBox(height: 18),
            toggle(
              1,
              glutenFreeFilterSet,
              'Gluten-free',
              'Only include gluten-free meals.',
            ),
            toggle(
              2,
              lactoseFreeFilterSet,
              'Lactose-free',
              'Only include lactose-free meals.',
            ),
            toggle(
              3,
              vegetarianFilterSet,
              'Vegetarian',
              'Only include vegetarian meals.',
            ),
            toggle(4, veganFilterSet, 'Vegan', 'Only include vegan meals.'),
          ],
        ),
      ),
    );
  }
}
