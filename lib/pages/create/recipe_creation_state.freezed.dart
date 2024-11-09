// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'recipe_creation_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$RecipeCreation {
  bool get creationInProgress => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $RecipeCreationCopyWith<RecipeCreation> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RecipeCreationCopyWith<$Res> {
  factory $RecipeCreationCopyWith(
          RecipeCreation value, $Res Function(RecipeCreation) then) =
      _$RecipeCreationCopyWithImpl<$Res, RecipeCreation>;
  @useResult
  $Res call({bool creationInProgress});
}

/// @nodoc
class _$RecipeCreationCopyWithImpl<$Res, $Val extends RecipeCreation>
    implements $RecipeCreationCopyWith<$Res> {
  _$RecipeCreationCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? creationInProgress = null,
  }) {
    return _then(_value.copyWith(
      creationInProgress: null == creationInProgress
          ? _value.creationInProgress
          : creationInProgress // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$RecipeCreationImplCopyWith<$Res>
    implements $RecipeCreationCopyWith<$Res> {
  factory _$$RecipeCreationImplCopyWith(_$RecipeCreationImpl value,
          $Res Function(_$RecipeCreationImpl) then) =
      __$$RecipeCreationImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({bool creationInProgress});
}

/// @nodoc
class __$$RecipeCreationImplCopyWithImpl<$Res>
    extends _$RecipeCreationCopyWithImpl<$Res, _$RecipeCreationImpl>
    implements _$$RecipeCreationImplCopyWith<$Res> {
  __$$RecipeCreationImplCopyWithImpl(
      _$RecipeCreationImpl _value, $Res Function(_$RecipeCreationImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? creationInProgress = null,
  }) {
    return _then(_$RecipeCreationImpl(
      creationInProgress: null == creationInProgress
          ? _value.creationInProgress
          : creationInProgress // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$RecipeCreationImpl implements _RecipeCreation {
  const _$RecipeCreationImpl({required this.creationInProgress});

  @override
  final bool creationInProgress;

  @override
  String toString() {
    return 'RecipeCreation(creationInProgress: $creationInProgress)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RecipeCreationImpl &&
            (identical(other.creationInProgress, creationInProgress) ||
                other.creationInProgress == creationInProgress));
  }

  @override
  int get hashCode => Object.hash(runtimeType, creationInProgress);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$RecipeCreationImplCopyWith<_$RecipeCreationImpl> get copyWith =>
      __$$RecipeCreationImplCopyWithImpl<_$RecipeCreationImpl>(
          this, _$identity);
}

abstract class _RecipeCreation implements RecipeCreation {
  const factory _RecipeCreation({required final bool creationInProgress}) =
      _$RecipeCreationImpl;

  @override
  bool get creationInProgress;
  @override
  @JsonKey(ignore: true)
  _$$RecipeCreationImplCopyWith<_$RecipeCreationImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
