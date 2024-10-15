import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals/providers/meals_provider.dart';

enum Filters {
  lactoseFree,
  glutenFree,
  vegetarian,
  vegan,
}

class FiltersNotifier extends StateNotifier<Map<Filters, bool>> {
  FiltersNotifier()
      : super({
          Filters.lactoseFree: false,
          Filters.glutenFree: false,
          Filters.vegetarian: false,
          Filters.vegan: false,
        });
  void setFilters(Map<Filters, bool> myFilters) {
    state = myFilters;
  }

  void setFilter(Filters filter, bool isActive) {
    state = {
      ...state,
      filter: isActive,
    };
  }
}

final filtersProvider =
    StateNotifierProvider<FiltersNotifier, Map<Filters, bool>>(
  (ref) => FiltersNotifier(),
);

final filterMealsProvider = Provider((ref) {
  final meals = ref.watch(mealsProvider);
  final activeFilters = ref.watch(filtersProvider);
  meals.where(
    (e) {
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
});
