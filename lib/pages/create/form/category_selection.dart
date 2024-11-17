part of 'recipe_form.dart';

class _CategorySelection extends HookConsumerWidget {
  final ValueNotifier<int> categorySection;

  const _CategorySelection(this.categorySection, {super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final progressState = ref.watch(progressControllerProvider);

    return ValueListenableBuilder(
      valueListenable: categorySection,
      builder: (context, value, child) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const TitleText("Wybierz kategorię"),
          for (RecipeCategory category in RecipeCategory.values)
            ListTile(
              title: Text(category.name),
              leading: Radio<int>(
                value: RecipeCategory.values.indexOf(category) + 1,
                groupValue: value,
                activeColor: Colors.blue,
                fillColor: WidgetStateProperty.all(Colors.blue),
                splashRadius: 20,
                onChanged: progressState.inProgress
                    ? null
                    : (value) {
                        if (value != null) {
                          categorySection.value = value;
                        }
                      },
              ),
            )
        ],
      ),
    );
  }
}

class _PicturePicker extends HookConsumerWidget {
  final ValueNotifier<String?> imageSection;

  const _PicturePicker(this.imageSection);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final onImagePickedAction = useImagePickerAction(
      onImagePicked: (value) => imageSection.value = value,
    );
    final progressState = ref.watch(progressControllerProvider);

    return ValueListenableBuilder(
      valueListenable: imageSection,
      builder: (context, value, child) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const TitleText("Dodaj zdjęcie"),
          if (value == null)
            AspectRatio(
              aspectRatio: 16 / 9,
              child: Stack(
                children: [
                  Positioned(
                    child: IconButton(
                      onPressed:
                          progressState.inProgress ? null : onImagePickedAction,
                      icon: const Icon(Icons.add),
                    ),
                  )
                ],
              ),
            ),
          if (value != null)
            InkWell(
              onTap: progressState.inProgress ? null : onImagePickedAction,
              child: Image.file(
                File(value),
                fit: BoxFit.cover,
              ),
            ),
        ],
      ),
    );
  }
}

class _RecipeSteps extends HookConsumerWidget {
  final TextEditingController stepsController;

  const _RecipeSteps(this.stepsController);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final progressState = ref.watch(progressControllerProvider);
    return SizedBox(
      width: double.infinity,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const TitleText("Przepis"),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: AiAssistedTextField(
                      controller: stepsController,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}

VoidCallback useImagePickerAction(
    {required void Function(String?) onImagePicked}) {
  return useCallback(() async {
    XFile? file = await ImagePicker().pickImage(
        source: ImageSource.gallery, maxHeight: 1800, maxWidth: 1800);

    if (file != null) {
      onImagePicked(file.path);
    }
  }, [onImagePicked]);
}
