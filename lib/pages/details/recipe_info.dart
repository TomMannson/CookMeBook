import 'package:flutter/material.dart';

import '../../components/utils/custom_fonts.dart';
import 'bulet_point.dart';

class RecipeInfo extends StatelessWidget {
  const RecipeInfo({super.key});

  @override
  Widget build(BuildContext context) {
    final styleTitleLarge = Theme.of(context)
        .textTheme
        .headlineMedium!
        .copyWith(fontWeight: FontWeight.bold);
    final styleTitle = Theme.of(context).textTheme.titleMedium!;

    return Expanded(
      flex: 2,
      child: Container(
        color: Colors.white,
        width: double.infinity,
        height: double.infinity,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.all(32),
                child: Column(
                  children: [
                    RecipeNameBar(
                      styleTitleLarge: styleTitleLarge,
                      action: () {
                        return EditButton(
                          onClick: () {},
                        );
                      },
                    ),
                    RecipeNutritions(),
                    SizedBox(height: 32,),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Przepis", style: styleTitle),
                        SizedBox(
                          height: 8,
                        ),
                        for (int i = 0; i < 15; i++)
                          BulletPointItem(ingredientName: "Twaróg rozetrzeć widelcem (nie musi być dokładnie) i zmiksować z jajkiem oraz dowolnym słodzidłem. Twaróg rozetrzeć widelcem (nie musi być dokładnie) i zmiksować z jajkiem oraz dowolnym słodzidłem.", number: i + 1,)
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class EditButton extends StatelessWidget {
  final VoidCallback onClick;

  const EditButton({
    required this.onClick,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onClick,
      icon: const Icon(
        CustomIcons.pen,
        size: 16,
      ),
    );
  }
}

typedef WidgetFactory = Widget Function();

class RecipeNutritions extends StatelessWidget {
  const RecipeNutritions({super.key});

  @override
  Widget build(BuildContext context) {
    const protein = 8;
    const carbs = 20;
    const fat = 2.5;

    return Row(
      children: [
        Icon(Icons.access_time),
        SizedBox(
          width: 8,
        ),
        Text("2 dni"),
        SizedBox(
          width: 16,
        ),
        Icon(Icons.access_time),
        SizedBox(
          width: 8,
        ),
        Text("6 porcji"),
        SizedBox(
          width: 16,
        ),
        Icon(Icons.access_time),
        SizedBox(
          width: 8,
        ),
        Text("150 kcal"),
        SizedBox(
          width: 16,
        ),
        Text("(B=$protein\g, W=$carbs\g, T=$fat\g)"),
      ],
    );
  }
}

class RecipeNameBar extends StatelessWidget {
  const RecipeNameBar(
      {super.key, required this.styleTitleLarge, required this.action});

  final TextStyle styleTitleLarge;
  final WidgetFactory action;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 1,
          child: Text(
            "Pieczone pączki twarogowe (FIT)",
            style: styleTitleLarge,
          ),
        ),
        action(),
      ],
    );
  }
}

Color getColor(int indicator) {
  if (indicator % 2 == 0) {
    return Colors.red;
  } else {
    return Colors.yellow;
  }
}
