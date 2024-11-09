import 'package:envied/envied.dart';

part 'app_env.g.dart';

@Envied(path: '.env', useConstantCase: true)
final class Env {
  @EnviedField(varName: 'RECIPE_WEBHOOK')
  static const String recipeWebhook = _Env.recipeWebhook;
}
