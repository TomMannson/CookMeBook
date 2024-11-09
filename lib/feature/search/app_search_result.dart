import 'dart:io';

import 'package:cook_me_book/data/recipe.dart';
import 'package:cook_me_book/feature/search/search_state.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class AppSearchResults extends HookConsumerWidget {
  const AppSearchResults({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final recipes = ref.watch(searchStateProvider);

    return recipes.when(
      data: (data) {
        return Stack(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 24,
              ),
              child: GridView.builder(
                shrinkWrap: true,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  childAspectRatio: 16 / 9,
                  crossAxisSpacing: 16.0,
                  mainAxisSpacing: 16.0,
                ),
                itemCount: data.foundRecipes.length,
                itemBuilder: (context, index) {
                  final item = data.foundRecipes[index];
                  return InkWell(
                    child: RecipeItem(item),
                    onTap: () {
                      context.push("/details/${item.id!}");
                    },
                  );
                },
              ),
            )
          ],
        );
      },
      loading: () {
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
      error: (error, stack) {
        return const Center(
          child: Text("Error"),
        );
      },
    );
  }
}

class RecipeItem extends StatelessWidget {
  final Recipe recipe;

  const RecipeItem(
    this.recipe, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: ClipRRect(
        borderRadius: const BorderRadius.all(Radius.circular(24)),
        child: Container(
          color: Colors.blue,
          child: Padding(
            padding: EdgeInsets.all(4),
            child: Column(
              children: [
                ReceipeImage(imagePath: recipe.photoPath),
                RecipeName(recipe.name),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class RecipeName extends StatelessWidget {
  final String name;

  const RecipeName(
    this.name, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 1,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: Text(
            style: TextStyle(color: Colors.white, fontSize: 16),
            overflow: TextOverflow.fade,
            name,
          ),
        ),
      ),
    );
  }
}

class ReceipeImage extends StatelessWidget {
  String? imagePath;

  ReceipeImage({
    this.imagePath,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 3,
      child: ClipRRect(
        borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(22), topRight: Radius.circular(22)),
        child: buildImage(imagePath),
      ),
    );
  }

  Widget buildImage(String? path) {
    if (path == null) {
      return Container(
        height: double.infinity,
        width: double.infinity,
        color: Colors.white,
      );
    } else {
      return Container(
        height: double.infinity,
        width: double.infinity,
        color: Colors.white,
        child: Image.file(
          File(path),
          fit: BoxFit.cover,
        ),
      );
    }
  }
}
