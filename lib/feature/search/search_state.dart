import 'package:cook_me_book/data/recipe.dart';
import 'package:cook_me_book/pages/create/recipe_cache_notifier.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'search_state.freezed.dart';
part 'search_state.g.dart';

@freezed
class Search with _$Search {
  const factory Search({
    required String searchText,
    RecipeCategory? category,
    required List<Recipe> foundRecipes,
  }) = _Search;
}

@riverpod
class SearchState extends _$SearchState {
  @override
  Future<Search> build() async {
    ref.watch(recipeCacheNotifierStateProvider);
    final repository = await ref.read(recipeRepositoryProvider.future);

    final currentState = state.valueOrNull;
    if (currentState != null) {
      final searchResult = await repository.findWith(
          currentState.searchText, currentState.category);

      return Search(
        searchText: currentState.searchText,
        foundRecipes: searchResult,
      );
    }
    return const Search(searchText: "", foundRecipes: []);
  }

  Future<void> clearCategory() async {
    final currentState = await future;
    _performSearch(currentState.searchText, null, false);
  }

  Future<void> setCategory(RecipeCategory searchText) async {
    final currentState = await future;
    _performSearch(currentState.searchText, searchText, false);
  }

  Future<void> search(String searchText) async {
    final currentState = await future;
    await _performSearch(searchText, currentState.category, true);
  }

  Future<void> _performSearch(
      String searchText, RecipeCategory? category, bool debounce) async {
    try {
      var currentState = await future;
      state = AsyncData(currentState.copyWith(searchText: searchText));

      if (debounce) {
        await Future<void>.delayed(const Duration(milliseconds: 500));
      }

      currentState = await future;
      if (searchText != currentState.searchText) {
        return;
      }

      // We now create the client and close it when the provider is disposed.
      final repository = await ref.read(recipeRepositoryProvider.future);
      final searchResult = await repository.findWith(searchText, category);

      state = AsyncData(
        currentState.copyWith(
            searchText: searchText,
            foundRecipes: searchResult,
            category: category),
      );
    } finally {}
  }
}
