import 'package:cook_me_book/components/basic/decorated_form_field.dart';
import 'package:cook_me_book/components/basic/title_text.dart';
import 'package:cook_me_book/components/style/input_style.dart';
import 'package:cook_me_book/pages/create/progress/progress_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

const servingNumberInputWidth = 80.0;
const timeInputWidth = 160.0;

class RecipePortoinsField extends HookConsumerWidget {
  final TextEditingController portionsController;
  final TextEditingController timeController;

  const RecipePortoinsField(this.portionsController, this.timeController,
      {super.key});

  @override
  Widget build(
    BuildContext context,
    WidgetRef ref,
  ) {
    final progressState = ref.watch(progressControllerProvider);

    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const TitleText("Ilość porcji"),
              Row(
                children: [
                  SizedBox(
                    width: servingNumberInputWidth,
                    child: TextField(
                      enabled: !progressState.inProgress,
                      keyboardType: TextInputType.number,
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      decoration: inputDecoration(),
                      controller: portionsController,
                    ),
                  )
                ],
              )
            ],
          ),
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const TitleText("Czas przygotowywania"),
              Row(
                children: [
                  SizedBox(
                    width: timeInputWidth,
                    child: DecoratedFormField(
                      controller: timeController,
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ],
    );
  }
}
