import 'package:flutter/material.dart';
import 'package:meals/providers/filters_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FiltersScreen extends ConsumerWidget {
  const FiltersScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final activeFilters = ref.watch(filtersProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Filters'),
      ),
      body: Column(
        children: [
          SwitchListTile(
            value: activeFilters[Filters.glutenFree]!,
            onChanged: (value) => ref
                .read(filtersProvider.notifier)
                .setFilter(Filters.glutenFree, value),
            activeColor: Theme.of(context).colorScheme.tertiary,
            contentPadding: const EdgeInsets.only(right: 24, left: 34),
            title: Text(
              'Gluten-free',
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    color: Theme.of(context).colorScheme.onBackground,
                  ),
            ),
            subtitle: Text(
              'Only include gluten-free meals',
              style: Theme.of(context).textTheme.labelMedium!.copyWith(
                    color: Theme.of(context).colorScheme.onBackground,
                  ),
            ),
          ),
          SwitchListTile(
            value: activeFilters[Filters.lactoseFree]!,
            onChanged: (value) => ref
                .read(filtersProvider.notifier)
                .setFilter(Filters.lactoseFree, value),
            activeColor: Theme.of(context).colorScheme.tertiary,
            contentPadding: const EdgeInsets.only(right: 24, left: 34),
            title: Text(
              'Lactose-free',
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    color: Theme.of(context).colorScheme.onBackground,
                  ),
            ),
            subtitle: Text(
              'Only include Lactose-free meals',
              style: Theme.of(context).textTheme.labelMedium!.copyWith(
                    color: Theme.of(context).colorScheme.onBackground,
                  ),
            ),
          ),
          SwitchListTile(
            value: activeFilters[Filters.vegetarian]!,
            onChanged: (value) => ref
                .read(filtersProvider.notifier)
                .setFilter(Filters.vegetarian, value),
            activeColor: Theme.of(context).colorScheme.tertiary,
            contentPadding: const EdgeInsets.only(right: 24, left: 34),
            title: Text(
              'Vegitarian-free',
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    color: Theme.of(context).colorScheme.onBackground,
                  ),
            ),
            subtitle: Text(
              'Only include vegitarian-free meals',
              style: Theme.of(context).textTheme.labelMedium!.copyWith(
                    color: Theme.of(context).colorScheme.onBackground,
                  ),
            ),
          ),
          SwitchListTile(
            value: activeFilters[Filters.vegan]!,
            onChanged: (value) => ref
                .read(filtersProvider.notifier)
                .setFilter(Filters.vegan, value),
            activeColor: Theme.of(context).colorScheme.tertiary,
            contentPadding: const EdgeInsets.only(right: 24, left: 34),
            title: Text(
              'vegan-free',
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    color: Theme.of(context).colorScheme.onBackground,
                  ),
            ),
            subtitle: Text(
              'Only include Vegan-free meals',
              style: Theme.of(context).textTheme.labelMedium!.copyWith(
                    color: Theme.of(context).colorScheme.onBackground,
                  ),
            ),
          ),
        ],
      ),
    );
  }
}
