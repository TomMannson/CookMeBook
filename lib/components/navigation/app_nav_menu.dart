import 'package:cook_me_book/data/recipe.dart';
import 'package:cook_me_book/feature/search/search_state.dart';
import 'package:cook_me_book/pages/create/form/recipe_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class AppNavMenu extends HookConsumerWidget {
  const AppNavMenu({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedCategory = useState<RecipeCategory?>(null);

    return Material(
      color: Colors.transparent,
      child: Column(children: [
        _NavItem(
          "Wszystkie",
          null == selectedCategory.value,
          () {
            selectedCategory.value = null;
            ref.read(searchStateProvider.notifier).clearCategory();
          },
        ),
        for (RecipeCategory category in allRecipeCategories)
          _NavItem(
            category.name,
            category == selectedCategory.value,
            () {
              selectedCategory.value = category;
              ref.read(searchStateProvider.notifier).setCategory(category);
            },
          )
      ]),
    );
  }
}

class _NavItem extends StatelessWidget {
  final String _text;
  final bool _selected;
  final VoidCallback onSelected;

  const _NavItem(this._text, this._selected, this.onSelected, {super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onSelected,
      child: ListTile(
        minTileHeight: 48,
        selected: _selected,
        selectedTileColor: Colors.amber,
        title: Text(
          _text,
          style: const TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
