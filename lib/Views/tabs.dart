import 'package:flutter/material.dart';
import 'package:meals/Views/categories.dart';
import 'package:meals/Views/meals.dart';
import 'package:meals/data/dummy_data.dart';

class TabsView extends StatefulWidget {
  const TabsView({super.key});

  @override
  State<TabsView> createState() {
    return _TabsViewState();
  }
}

class _TabsViewState extends State<TabsView> {
  int selectedTabIndex = 0;

  void selectPage(int index) {
    setState(() {
      selectedTabIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget activeTab = switch (selectedTabIndex) {
      0 => CategoriesView(),
      1 => MealsView(meals: dummyMeals),
      _ => Text(''),
    };

    Widget activeTabTitle = switch (selectedTabIndex) {
      0 => Text('Categories'),
      1 => Text('Favorites'),
      _ => Text(''),
    };

    return Scaffold(
      appBar: AppBar(title: activeTabTitle),
      body: activeTab,
      bottomNavigationBar: BottomNavigationBar(
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
    );
  }
}
