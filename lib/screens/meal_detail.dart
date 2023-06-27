import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_first_app/model/meal.dart';
import 'package:my_first_app/providers/favourite_provider.dart';

class MealsDetailScreen extends ConsumerWidget {
  const MealsDetailScreen({super.key, required this.meal});

  final Meal meal;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final favoriteMeal = ref.watch(favouriteMealProvider);
    final isFvorite = favoriteMeal.contains(meal);

    return Scaffold(
      appBar: AppBar(
        title: Text(meal.title),
        actions: [
          IconButton(
            onPressed: () {
              final wasAdded = ref
                  .read(favouriteMealProvider.notifier)
                  .toggleMealFavourite(meal);
              ScaffoldMessenger.of(context).clearSnackBars();
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text(wasAdded
                    ? 'Meal added as favorite'
                    : 'Meal removed as favorite'),
              ));
            },
            icon: AnimatedSwitcher(
              duration: const Duration(milliseconds: 200),
              transitionBuilder: (child, animation) {
                return RotationTransition(
                  turns: Tween(begin: 0.5, end: 1.0).animate(animation),
                  child: child,
                );
              },
              child: Icon(
                isFvorite ? Icons.star : Icons.star_border,
                key: ValueKey(isFvorite),
              ),
            ),
          )
        ],
      ),
      body: Hero(
        tag: meal.id,
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.only(bottom: 100),
            child: Column(
              children: [
                meal.imageUrl,
                const SizedBox(
                  height: 14,
                ),
                Text(
                  meal.intro != null ? 'About The Food' : "",
                  style: Theme.of(context).textTheme.titleLarge!.copyWith(
                        color: Theme.of(context).colorScheme.primary,
                        fontWeight: FontWeight.bold,
                      ),
                ),
                SizedBox(
                  height: meal.intro != null ? 14 : 0,
                ),
                Text(
                  meal.intro != null ? meal.intro! : "",
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        color: Theme.of(context).colorScheme.primary,
                      ),
                ),
                SizedBox(
                  height: meal.intro != null ? 12 : 0,
                ),
                Text(
                  'Ingredient',
                  style: Theme.of(context).textTheme.titleLarge!.copyWith(
                        color: Theme.of(context).colorScheme.primary,
                        fontWeight: FontWeight.bold,
                      ),
                ),
                const SizedBox(
                  height: 14,
                ),
                for (final ingredient in meal.ingredients)
                  Text(
                    ingredient,
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          color: Theme.of(context).colorScheme.primary,
                          // fontSize: 13,
                        ),
                  ),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  'Steps',
                  style: Theme.of(context).textTheme.titleLarge!.copyWith(
                        color: Theme.of(context).colorScheme.primary,
                        fontWeight: FontWeight.bold,
                      ),
                ),
                const SizedBox(
                  height: 14,
                ),
                for (final step in meal.steps)
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 25, vertical: 0),
                    child: Text(
                      step,
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            color: Theme.of(context).colorScheme.primary,
                          ),
                    ),
                  )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
