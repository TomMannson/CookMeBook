import 'dart:developer';

import 'package:cook_me_book/data/recipe.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:functional_widget_annotation/functional_widget_annotation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../components/navigation/mini/app_mininavigationbar.dart';
import '../../feature/recipe/recipe_name_input.dart';
import '../../feature/recipe/recipe_nutrition_picker.dart';
import '../../feature/recipe/recipe_portions_input.dart';
import '../../feature/recipe/reipe_ingredients_picker.dart';

part 'create.g.dart';

@hcwidget
Widget creationPage(BuildContext context, {String? recipeId}) {
  final windowSize = MediaQuery.sizeOf(context);
  return SafeArea(
    child: Scaffold(
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            // todo Add sliver to squize header
            NavBar(windowSize: windowSize),
            Expanded(
              flex: 1,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 1,
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.all(32.0),
                        child: Column(
                          children: [
                            RecipeNameInput(),
                            SizedBox(height: 32),
                            RecipePortoinsField(),
                            SizedBox(height: 32),
                            RecipeNutritionPicker(),
                            SizedBox(height: 32),
                            PicturePicker()
                          ],
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.all(32.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            IngredientPicker(),
                            _RecipeSteps(),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    ),
  );
}

class NavBar extends StatelessWidget {
  const NavBar({
    super.key,
    required this.windowSize,
  });

  final Size windowSize;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 58,
      height: windowSize.height,
      child: Container(
        child: const AppMiniNavigationBar(),
      ),
    );
  }
}

class PicturePicker extends HookWidget {
  final String? link;

  const PicturePicker({this.link, super.key});

  @override
  Widget build(BuildContext context) {
    final style = Theme.of(context)
        .textTheme
        .titleMedium!
        .copyWith(fontWeight: FontWeight.bold);
    final nameController = useTextEditingController();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Dodaj zdjęcie",
          style: style,
        ),
        if (link == null) AspectRatio(aspectRatio: 16 / 9, child: Placeholder())
      ],
    );
  }
}

class _RecipeSteps extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final styleTitle = Theme.of(context).textTheme.titleMedium!;
    return Container(
      width: double.infinity,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Przepis", style: styleTitle),
          _Recipe(),
        ],
      ),
    );
  }
}

class _Recipe extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final nameController = useTextEditingController();

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: TextField(
                minLines: 6,
                maxLines: 2000,
                decoration: new InputDecoration(
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.blue,
                    ),
                  ),
                  border: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.grey,
                    ),
                  ),
                  hintText: '',
                ),
                controller: nameController,
                onChanged: (value) {},
              ),
            ),
          ],
        ),
        SizedBox(
          height: 16,
        ),
        _Apppp("a")
      ],
    );
  }
}

@hcwidget
Widget __apppp(BuildContext context, WidgetRef ref, String data) {
  final boredSuggestion = ref.watch(helloWorldProvider);
  ref.listen(recipeRepositoryProvider, (p, n) {
    log("REPO RELOADED");
  });
  return MaterialButton(
    onPressed: () {
      ref.read(recipeRepositoryProvider).value?.create("recipe");

    },
    child: Text("Create"),
  );
}

@riverpod
String helloWorld(HelloWorldRef ref) {
  return 'Hello world';
}
