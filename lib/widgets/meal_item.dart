import 'package:flutter/material.dart';
import 'package:meals/Screen/meal_item_screen.dart';
import 'package:meals/models/meal.dart';
import 'package:transparent_image/transparent_image.dart';

class MealItem extends StatelessWidget {
  const MealItem({super.key, required this.meal});
  final Meal meal;
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      clipBehavior: Clip.hardEdge,
      elevation: 2,
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => MealItemScreen(meal),
            ),
          );
        },
        splashColor: Theme.of(context).secondaryHeaderColor,
        child: Stack(
          children: [
            Hero(
              tag: meal.id,
              child: FadeInImage(
                placeholder: MemoryImage(kTransparentImage),
                image: NetworkImage(meal.imageUrl),
                fit: BoxFit.cover,
                height: 200,
                width: double.infinity,
              ),
            ),
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: Container(
                color: Colors.black54,
                padding:
                    const EdgeInsets.symmetric(vertical: 6, horizontal: 40),
                child: Column(
                  children: [
                    Text(
                      meal.title,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      softWrap: true,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.access_time,
                          size: 16,
                        ),
                        const SizedBox(
                          width: 8,
                        ),
                        Text(
                          '${meal.duration.toString()} min',
                          style: const TextStyle(
                              fontSize: 15, color: Colors.white),
                        ),
                        const SizedBox(
                          width: 15,
                        ),
                        const Icon(
                          Icons.work,
                          size: 16,
                        ),
                        const SizedBox(
                          width: 8,
                        ),
                        Text(
                          meal.complexity.name,
                          style: const TextStyle(
                              fontSize: 15, color: Colors.white),
                        ),
                        const SizedBox(
                          width: 15,
                        ),
                        Text(
                          '\$  ${meal.affordability.name}',
                          style: const TextStyle(
                              fontSize: 15, color: Colors.white),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
