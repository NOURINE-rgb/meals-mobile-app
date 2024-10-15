import 'package:flutter/material.dart';
import 'package:meals/Screen/meals.dart';
import 'package:meals/data/dummy_data.dart';
import 'package:meals/widgets/category_grid_item.dart';

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({super.key});

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
      lowerBound: 0,
      upperBound: 1,
    );
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _selectedCategory(BuildContext context, Meals meal) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => meal,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animationController,
      child: GridView(
        padding: const EdgeInsets.all(20),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 20,
            mainAxisSpacing: 20,
            childAspectRatio: 1.5),
        children: [
          ...availableCategories.map(
            (e) => CategoryGridItem(
              category: e,
              onSelectedCategory: _selectedCategory,
            ),
          ),
        ],
      ),
      builder: (context, child) =>  SlideTransition(
        position: Tween(
          begin: const Offset(0, 0.3),
          end: const Offset(0, 0),
        ).animate(
          CurvedAnimation(
              parent: _animationController, curve: Curves.easeInOut),
        ),
        child: child,
      ),
    );
  }
}
