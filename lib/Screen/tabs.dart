import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals/Screen/categories.dart';
import 'package:meals/Screen/filters.dart';
import 'package:meals/Screen/main_drawer.dart';
import 'package:meals/Screen/meals.dart';
import 'package:meals/models/meal.dart';
import 'package:meals/providers/favorites_provider.dart';
import 'package:meals/providers/filters_provider.dart';

const Map<Filters, bool> constFilters = {
  Filters.glutenFree: false,
  Filters.lactoseFree: false,
  Filters.vegan: false,
  Filters.vegetarian: false,
};

class TabsScreen extends ConsumerStatefulWidget {
  const TabsScreen({super.key});
  @override
  ConsumerState<TabsScreen> createState() {
    return _TabdsScreenState();
  }
}

class _TabdsScreenState extends ConsumerState<TabsScreen> {
  int _index = 0;
  final List<Meal> listFavorites = [];
  void _changePage(int index) {
    setState(() {
      _index = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    void setScreen(String identifier) async {
      Navigator.pop(context);
      if (identifier == 'Filters') {
      await Navigator.push<Map<Filters, bool>>(
          context,
          MaterialPageRoute(
            builder: (context) => const FiltersScreen(),
          ),
        );
      }
    }

    Widget content = const CategoriesScreen();
    String title = 'Categories';
    final listFavorites = ref.watch(favoritesMealsProvider);
    if (_index == 1) {
      setState(() {
        content = Meals(
          meal: listFavorites,
        );
        title = 'Your Favorites';
      });
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      drawer: MainDrawer(setScreen),
      body: content,
      bottomNavigationBar: BottomNavigationBar(
        onTap: (value) => _changePage(value),
        currentIndex: _index,
        backgroundColor:
            Theme.of(context).colorScheme.primaryContainer.withOpacity(0.4),
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.set_meal), label: 'Categories'),
          BottomNavigationBarItem(icon: Icon(Icons.star), label: 'Favorites'),
        ],
      ),
    );
  }
}
