import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals/models/meal.dart';
import 'package:meals/providers/favorites_provider.dart';
import 'package:transparent_image/transparent_image.dart';

class MealItemScreen extends ConsumerWidget {
  const MealItemScreen(this.meal, {super.key});
  final Meal meal;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final favoritesMeals = ref.watch(favoritesMealsProvider);
    final isFavorites = favoritesMeals.contains(meal);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          meal.title,
        ),
        actions: [
          IconButton(
            onPressed: () {
              //  after i eat the dinnner i will change it after i excute the code
              ScaffoldMessenger.of(context).clearSnackBars();
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(ref
                      .read(favoritesMealsProvider.notifier)
                      .toggleMeal(meal)),
                  duration: const Duration(seconds: 3),
                ),
              );
            },
            icon: AnimatedSwitcher(
              duration: const Duration(milliseconds: 400),
              transitionBuilder: (child, animation) {
                return RotationTransition(
                  turns: Tween<double>(begin: 0.7, end : 1).animate(animation),
                  child: child,
                );
              },
              child: Icon(isFavorites ? Icons.star : Icons.star_border,key: ValueKey(isFavorites),),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Hero(
              tag: meal.id,
              child: FadeInImage(
                placeholder: MemoryImage(kTransparentImage),
                image: NetworkImage(meal.imageUrl),
                fit: BoxFit.cover,
                height: 300,
                width: double.infinity,
              ),
            ),
            const SizedBox(
              height: 17,
            ),
            Text(
              'Ingredients',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                // color: Colors.orange[300],
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
            const SizedBox(
              height: 17,
            ),
            ...meal.ingredients.map(
              (e) => Text(
                e.toString(),
                style: const TextStyle(color: Colors.white, fontSize: 14),
              ),
            ),
            const SizedBox(
              height: 19,
            ),
            Text(
              'Steps',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.orange[300],
              ),
            ),
            const SizedBox(
              height: 19,
            ),
            for (final step in meal.steps)
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 19, vertical: 16),
                child: Text(
                  step.toString(),
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
