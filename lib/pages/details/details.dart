import 'package:cook_me_book/pages/details/recipe_info.dart';
import 'package:flutter/material.dart';

import '../../components/header/image_header.dart';
import '../../components/navigation/mini/app_mininavigationbar.dart';
import '../../components/utils/custom_fonts.dart';
import 'bulet_point.dart';

class DetailPage extends StatefulWidget {
  const DetailPage({super.key});

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  @override
  Widget build(BuildContext context) {
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
                  children: [
                    Expanded(
                      flex: 1,
                      child: Container(
                        color: Colors.blue.shade100,
                        child: Column(
                          children: [
                            const ImageHeader(),
                            _IngredientsList(),
                          ],
                        ),
                      ),
                    ),
                    const RecipeInfo()
                  ],
                ),
              )
            ],
          ),
        ), // This trailing comma makes auto-formatting nicer for build methods.
      ),
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

class _IngredientsList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final styleTitle = Theme.of(context).textTheme.titleMedium!;
    return Expanded(
      child: SingleChildScrollView(
        child: Container(
          width: double.infinity,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Składniki", style: styleTitle),
                SizedBox(
                  height: 8,
                ),
                for (int i = 0; i < 15; i++)
                  BulletPointItem(ingredientName: "Ingredient + $i")
              ],
            ),
          ),
        ),
      ),
    );
  }
}
