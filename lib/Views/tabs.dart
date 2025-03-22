import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals/views/categories.dart';
import 'package:meals/views/filters.dart';
import 'package:meals/views/meals.dart';
import 'package:meals/widgets/main_drawer.dart';
import 'package:meals/providers/favorites_provider.dart';
import 'package:meals/providers/filters_provider.dart';

const kInitialFilters = {
  Filter.glutenFree: false,
  Filter.lactoseFree: false,
  Filter.vegetarian: false,
  Filter.vegan: false,
};

class TabsView extends ConsumerStatefulWidget {
  const TabsView({super.key});

  @override
  ConsumerState<TabsView> createState() {
    return _TabsViewState();
  }
}

class _TabsViewState extends ConsumerState<TabsView> {
  int selectedTabIndex = 0;

  void selectPage(int index) {
    setState(() {
      selectedTabIndex = index;
    });
  }

  void setScreenFromSideMenu(String identifier) async {
    Navigator.of(context).pop();
    if (identifier == 'filters') {
      Navigator.of(
        context,
      ).push(MaterialPageRoute(builder: (context) => FiltersView()));
    }
  }

  @override
  Widget build(BuildContext context) {
    final targetPlatform = Theme.of(context).platform;
    final favoriteMeals = ref.watch(favoriteMealsProvider);
    final availableMeals = ref.watch(filteredMealsProvider);

    Widget activeTab = switch (selectedTabIndex) {
      0 => CategoriesView(availableMeals: availableMeals),
      1 => MealsView(meals: favoriteMeals),
      _ => Text(''),
    };

    Widget activeTabTitle = switch (selectedTabIndex) {
      0 => Text('Categories'),
      1 => Text('Favorites'),
      _ => Text(''),
    };

    Widget tabBar = switch (targetPlatform) {
      TargetPlatform.android => BottomNavigationBar(
        onTap: selectPage,
        currentIndex: selectedTabIndex,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.set_meal),
            label: 'Categories',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Favorites',
          ),
        ],
      ),

      TargetPlatform.iOS => CupertinoTabBar(
        onTap: selectPage,
        currentIndex: selectedTabIndex,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.set_meal),
            label: 'Categories',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Favorites',
          ),
        ],
      ),

      _ => Text(''),
    };

    return Scaffold(
      appBar: AppBar(title: activeTabTitle),
      body: activeTab,
      bottomNavigationBar: tabBar,
      drawer: MainDrawer(onSelectScreen: setScreenFromSideMenu),
    );
  }
}
