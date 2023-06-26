import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_first_app/providers/meals_providers.dart';

enum Filters {
  glutenFree,
  lactoseFree,
  vegetarianFree,
  veganFree,
}

class FilterNotifier extends StateNotifier<Map<Filters, bool>> {
  FilterNotifier()
      : super({
          Filters.glutenFree: false,
          Filters.lactoseFree: false,
          Filters.vegetarianFree: false,
          Filters.veganFree: false,
        });

  void setFilters(Map<Filters, bool> chosenFilters) {
    state = chosenFilters;
  }

  void setFilter(Filters filter, bool isActive) {
    state = {
      ...state,
      filter: isActive,
    };
  }
}

final filterProvider =
    StateNotifierProvider<FilterNotifier, Map<Filters, bool>>(
        (ref) => FilterNotifier());

final filterMealProvider = Provider((ref) {
  final meals = ref.watch(mealsProvider);
  final activeFilters = ref.watch(filterProvider);
  
  return meals.where((meal) {
    if (activeFilters[Filters.glutenFree]! && !meal.isGlutenFree) {
      return false;
    }
    if (activeFilters[Filters.lactoseFree]! && !meal.isLactoseFree) {
      return false;
    }
    if (activeFilters[Filters.vegetarianFree]! && !meal.isVegetarian) {
      return false;
    }
    if (activeFilters[Filters.veganFree]! && !meal.isVegan) {
      return false;
    }
    return true;
  }).toList();
});
