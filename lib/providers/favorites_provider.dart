import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals/models/meal.dart';

class FavoritesMealsNotifier extends StateNotifier<List<Meal>> {
  FavoritesMealsNotifier() : super([]);
  String toggleMeal(Meal meal) {
    final isFavorites = state.contains(meal);
    if (isFavorites) {
      state = state
          .where(
            (element) => element.id != meal.id,
          )
          .toList();
      return "Meal are not include anymore";
    } else {
      state = [...state, meal];
      return "Meal added as favorites";
    }
  }
}

final favoritesMealsProvider =
    StateNotifierProvider<FavoritesMealsNotifier, List<Meal>>(
  (ref) => FavoritesMealsNotifier(),
);

