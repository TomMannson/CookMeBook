import 'package:cook_me_book/components/navigation/mini/app_mininavigationbar.dart';
import 'package:cook_me_book/data/recipe.dart';
import 'package:cook_me_book/pages/create/form_state.dart';
import 'package:cook_me_book/pages/create/progress/progress_controller.dart';
import 'package:cook_me_book/pages/create/recipe_cache_notifier.dart';
import 'package:cook_me_book/pages/create/recipe_creation_state.dart';
import 'package:cook_me_book/pages/create/recipe_extraction_state.dart';
import 'package:cook_me_book/pages/create/use_save_action.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'form/recipe_form.dart';

class CreationPage extends HookConsumerWidget {
  final String? recipeId;

  const CreationPage({this.recipeId, super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final windowSize = MediaQuery.sizeOf(context);
    final recipe = useState<Recipe?>(null);
    final form = useRecipeForm(recipe.value);
    final saveAction = useRecipeSave(
      form: form,
      ref: ref,
      context: context,
      recipeId: recipeId,
    );

    ref.listen(recipeCacheNotifierStateProvider, (prev, next) {
      if (next is RecipeCreated || next is RecipeEditted) {
        context.pop();
      }
    });

    ref.listen(recipeExtractionStateProvider, (prev, next) {
      if (prev != null) {
        if (prev.step == ProcessSteps.recipeExtraction &&
            next.step == ProcessSteps.idle) {
          if (next.extractedRecipe != null) {
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                content: Text("Przepis został poprawnie przetworzony")));
          } else {
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                content: Text("Nie udało się przetworzyć przepisu")));
          }
        }
      }
    });

    ref.listen(recipeExtractionStateProvider, (prev, next) {
      if (next.extractedRecipe == null) {
        return;
      }

      if (prev != null) {
        if (prev.extractedRecipe != next.extractedRecipe) {
          Recipe extracted = next.extractedRecipe!;
          recipe.value = extracted;
        }
      }
    });

    ref.listen(recipeLoadedProvider(recipeId), (prev, next) {
      if (next.value == null || next.value!.recipe == null) {
        return;
      }

      if (prev?.value != next.value) {
        Recipe extracted = next.value!.recipe!;
        recipe.value = extracted;
      }
    });

    return ProviderScope(
      overrides: [
        recipeFormProvider.overrideWith((ref) => form),
        recipeSaveHandlerProvider.overrideWith((ref) => saveAction),
      ],
      child: _CreationPageLayout(
        windowSize: windowSize,
      ),
    );
  }
}

class _CreationPageLayout extends StatelessWidget {
  final Size windowSize;

  const _CreationPageLayout({required this.windowSize});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              NavBar(windowSize: windowSize),
              const Expanded(
                child: _RecipeFormLayout(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _RecipeFormLayout extends ConsumerWidget {
  const _RecipeFormLayout();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final form = ref.watch(recipeFormProvider);

    return Container(
      color: Colors.grey.shade200,
      child: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: RecipeFormWidget(form: form),
            ),
          ),
          _BottomBar()
        ],
      ),
    );
  }
}

class _BottomBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Padding(
            padding: EdgeInsets.only(right: 8.0),
            child: Padding(
              padding: EdgeInsets.all(8.0),
              child: SubmitButton(),
            ),
          )
        ],
      ),
    );
  }
}

class SubmitButton extends HookConsumerWidget {
  const SubmitButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final saveAction = ref.watch(recipeSaveHandlerProvider);
    final progressState = ref.watch(progressControllerProvider);

    return TextButton(
      onPressed: progressState.inProgress ? null : saveAction,
      child: const Text("Save Recipe"),
    );
  }
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
