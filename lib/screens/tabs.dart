import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_first_app/providers/favourite_provider.dart';
import 'package:my_first_app/screens/categories.dart';
import 'package:my_first_app/screens/filters.dart';
// import 'package:my_first_app/screens/meal_detail.dart';
import 'package:my_first_app/screens/meals.dart';
import 'package:my_first_app/widgets/main_drawer.dart';
import 'package:my_first_app/providers/filter_provider.dart';

const kInitFilters = {
  Filters.glutenFree: false,
  Filters.lactoseFree: false,
  Filters.vegetarianFree: false,
  Filters.veganFree: false,
};

class TabScreen extends ConsumerStatefulWidget {
  const TabScreen({super.key});

  @override
  ConsumerState<TabScreen> createState() => _TabScreenState();
}

class _TabScreenState extends ConsumerState<TabScreen> {
  int _selectedIndex = 0;

  void navigateScreen(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void showMessage(String message) {}

  void selectScreen(String identifier) async {
    Navigator.of(context).pop();
    if (identifier == 'filter') {
      await Navigator.of(context).push<Map<Filters, bool>>(
        MaterialPageRoute(
          builder: (ctx) => const FiltersScreen(),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final availableMeals = ref.watch(filterMealProvider);
    Widget activePage = CategoriesScreen(
      availableMeal: availableMeals,
    );
    var activetPageTitle = 'Category';

    if (_selectedIndex == 1) {
      final favoriteMeal = ref.watch(favouriteMealProvider);
      activePage = MealsScreen(
        meals: favoriteMeal,
      );
      activetPageTitle = 'Favorite';
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(activetPageTitle),
      ),
      drawer: MainDrawer(
        onSelectScreen: selectScreen,
      ),
      body: activePage,
      bottomNavigationBar: BottomNavigationBar(
        onTap: navigateScreen,
        currentIndex: _selectedIndex,
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.category), label: 'Categories'),
          BottomNavigationBarItem(icon: Icon(Icons.star), label: 'Favorite')
        ],
      ),
    );
  }
}
