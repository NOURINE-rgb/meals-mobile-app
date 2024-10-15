import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals/providers/filters_provider.dart';
import 'package:meals/Screen/meals.dart';
import 'package:meals/models/category.dart';
import 'package:meals/models/meal.dart';
import 'package:meals/providers/meals_provider.dart';

class CategoryGridItem extends ConsumerWidget {
  const CategoryGridItem(
      {super.key, required this.category, required this.onSelectedCategory});
  final Category category;
  final void Function(BuildContext context, Meals meal) onSelectedCategory;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final meals = ref.watch(mealsProvider);
    final activeFilters = ref.watch(filtersProvider);
    final List<Meal> smallList = meals.where(
      (e) {
        if (!e.categories.contains(category.id)) {
          return false;
        }
        if (activeFilters[Filters.glutenFree]! && !e.isGlutenFree) {
          return false;
        }
        if (activeFilters[Filters.lactoseFree]! && !e.isLactoseFree) {
          return false;
        }
        if (activeFilters[Filters.vegan]! && !e.isVegan) {
          return false;
        }
        if (activeFilters[Filters.vegetarian]! && !e.isVegetarian) {
          return false;
        }
        return true;
      },
    ).toList();
    return InkWell(
      onTap: () {
        onSelectedCategory(
          context,
          Meals(
            title: category.title,
            meal: smallList,
          ),
        );
      },
      splashColor: Theme.of(context).secondaryHeaderColor,
      borderRadius: BorderRadius.circular(10),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              category.color.withOpacity(0.55),
              category.color.withOpacity(0.9)
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Text(
          category.title,
          style: Theme.of(context).textTheme.titleLarge!.copyWith(
                color: Theme.of(context).colorScheme.onBackground,
              ),
        ),
      ),
    );
  }
}
