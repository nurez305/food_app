import 'package:flutter/material.dart';

import '../model/category.dart';

class CategoryGrid extends StatelessWidget {
  const CategoryGrid({super.key, required this.category, required this.onChangeScreen});

  final Category category;
  final void Function() onChangeScreen;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onChangeScreen,
      borderRadius: BorderRadius.circular(16),
      splashColor: Theme.of(context).primaryColor,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          gradient: LinearGradient(colors: [
            category.color.withOpacity(0.56),
            category.color.withOpacity(0.09),
          ], begin: Alignment.topLeft, end: Alignment.bottomRight),
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
