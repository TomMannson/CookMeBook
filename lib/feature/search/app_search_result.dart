import 'package:cook_me_book/data/recipe.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class AppSearchResults extends HookConsumerWidget {
  const AppSearchResults({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final data = ref.watch(foundRecipesProvider('recipe'));


    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 24,
          ),
          child: GridView.builder(
            physics: const ScrollPhysics(),
            shrinkWrap: true,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              childAspectRatio: 16 / 9,
              crossAxisSpacing: 16.0,
              mainAxisSpacing: 16.0,
            ),
            itemCount: data.value?.length ?? 0,
            itemBuilder: (context, index) {
              return SizedBox(
                child: ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(24)),
                  child: Container(
                    color: Colors.blue,
                    child: Padding(
                      padding: EdgeInsets.all(4),
                      child: Column(
                        children: [
                          ReceipeImage(),
                          RecipeName(),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
        Positioned(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: FloatingActionButton(
              onPressed: () {
                context.push("/create");
              },
              backgroundColor: Colors.amber,
              child: Icon(
                Icons.add,
                color: Colors.white,
              ),
            ),
          ),
          // child: Container(color: Colors.green, width: 14, height: 14,),
          bottom: 0,
          right: 0,
        ),
      ],
    );
  }
}

class RecipeName extends StatelessWidget {
  const RecipeName({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Expanded(
      flex: 1,
      child: Padding(
        padding: EdgeInsets.all(8.0),
        child: Center(
          child: Text(
            style: TextStyle(color: Colors.white, fontSize: 16),
            overflow: TextOverflow.fade,
            "Nazwa przepisu asdasds sa asdasdss",
          ),
        ),
      ),
    );
  }
}

class ReceipeImage extends StatelessWidget {
  const ReceipeImage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 3,
      child: ClipRRect(
        borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(22), topRight: Radius.circular(22)),
        child: Container(
          height: double.infinity,
          width: double.infinity,
          color: Colors.white,
        ),
      ),
    );
  }
}
