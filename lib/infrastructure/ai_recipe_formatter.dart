import 'dart:convert';

import 'package:cook_me_book/app_env.dart';
import 'package:cook_me_book/data/recipe.dart';
import 'package:http/http.dart' as http;
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'ai_recipe_formatter.g.dart';

class AiFormater {
  Future<Recipe?> formatRecipeInText(String unformattedRecipe) async {
    final response = await http.post(
      Uri.parse("https://hook.eu2.make.com/${Env.recipeWebhook}"),
      body: {"query": unformattedRecipe},
    );

    if (response.statusCode == 200) {
      return Recipe.fromJson(jsonDecode(utf8.decode(response.bodyBytes)));
    } else {
      return null;
    }
  }

  Future<String?> formatTextWith(String unformattedText) async {
    final response = await http.post(
      Uri.parse("https://hook.eu2.make.com/${Env.recipeWebhook}"),
      body: {"fix": unformattedText},
    );

    if (response.statusCode == 200) {
      return utf8.decode(response.bodyBytes);
    } else {
      return null;
    }
  }

  Future<Recipe?> scrapeRecipeFromWeb({required String url}) async {
    final response = await http.post(
      Uri.parse("https://hook.eu2.make.com/${Env.recipeWebhook}"),
      body: {"scrapeUrl": url},
    );

    if (response.statusCode == 200) {
      return Recipe.fromJson(jsonDecode(utf8.decode(response.bodyBytes)));
    } else {
      return null;
    }
  }
}

@Riverpod(keepAlive: true)
AiFormater aiFormater(AiFormaterRef ref) {
  return AiFormater();
}
