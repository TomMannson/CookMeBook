import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../data/recipe.dart';

part 'database.g.dart';

@Riverpod(keepAlive: true)
Future<Isar> isarBuilder(IsarBuilderRef ref) async {
  final dir = await getApplicationDocumentsDirectory();
  return await Isar.open(
    [RecipeSchema],
    directory: dir.path,
  );
}
