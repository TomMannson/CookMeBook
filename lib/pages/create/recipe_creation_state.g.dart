// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'recipe_creation_state.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$recipeLoadedHash() => r'c2e82a32bcaac2310446eff5e1784758fba505d2';

/// Copied from Dart SDK
class _SystemHash {
  _SystemHash._();

  static int combine(int hash, int value) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + value);
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
    return hash ^ (hash >> 6);
  }

  static int finish(int hash) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
    // ignore: parameter_assignments
    hash = hash ^ (hash >> 11);
    return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
  }
}

/// See also [recipeLoaded].
@ProviderFor(recipeLoaded)
const recipeLoadedProvider = RecipeLoadedFamily();

/// See also [recipeLoaded].
class RecipeLoadedFamily extends Family<AsyncValue<RecipeLoaded>> {
  /// See also [recipeLoaded].
  const RecipeLoadedFamily();

  /// See also [recipeLoaded].
  RecipeLoadedProvider call(
    String? id,
  ) {
    return RecipeLoadedProvider(
      id,
    );
  }

  @override
  RecipeLoadedProvider getProviderOverride(
    covariant RecipeLoadedProvider provider,
  ) {
    return call(
      provider.id,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'recipeLoadedProvider';
}

/// See also [recipeLoaded].
class RecipeLoadedProvider extends AutoDisposeFutureProvider<RecipeLoaded> {
  /// See also [recipeLoaded].
  RecipeLoadedProvider(
    String? id,
  ) : this._internal(
          (ref) => recipeLoaded(
            ref as RecipeLoadedRef,
            id,
          ),
          from: recipeLoadedProvider,
          name: r'recipeLoadedProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$recipeLoadedHash,
          dependencies: RecipeLoadedFamily._dependencies,
          allTransitiveDependencies:
              RecipeLoadedFamily._allTransitiveDependencies,
          id: id,
        );

  RecipeLoadedProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.id,
  }) : super.internal();

  final String? id;

  @override
  Override overrideWith(
    FutureOr<RecipeLoaded> Function(RecipeLoadedRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: RecipeLoadedProvider._internal(
        (ref) => create(ref as RecipeLoadedRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        id: id,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<RecipeLoaded> createElement() {
    return _RecipeLoadedProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is RecipeLoadedProvider && other.id == id;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, id.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin RecipeLoadedRef on AutoDisposeFutureProviderRef<RecipeLoaded> {
  /// The parameter `id` of this provider.
  String? get id;
}

class _RecipeLoadedProviderElement
    extends AutoDisposeFutureProviderElement<RecipeLoaded>
    with RecipeLoadedRef {
  _RecipeLoadedProviderElement(super.provider);

  @override
  String? get id => (origin as RecipeLoadedProvider).id;
}

String _$recipeCreationStateHash() =>
    r'5da06e303d694d3a552d714bcf21ee14f52b4903';

/// See also [RecipeCreationState].
@ProviderFor(RecipeCreationState)
final recipeCreationStateProvider =
    AutoDisposeNotifierProvider<RecipeCreationState, RecipeCreation>.internal(
  RecipeCreationState.new,
  name: r'recipeCreationStateProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$recipeCreationStateHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$RecipeCreationState = AutoDisposeNotifier<RecipeCreation>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
