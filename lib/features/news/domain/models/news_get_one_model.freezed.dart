// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'news_get_one_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

NewsGetOneModelResponse _$NewsGetOneModelResponseFromJson(
    Map<String, dynamic> json) {
  return _NewsGetOneModelResponse.fromJson(json);
}

/// @nodoc
mixin _$NewsGetOneModelResponse {
  String get message => throw _privateConstructorUsedError;
  NewsModel get data => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $NewsGetOneModelResponseCopyWith<NewsGetOneModelResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $NewsGetOneModelResponseCopyWith<$Res> {
  factory $NewsGetOneModelResponseCopyWith(NewsGetOneModelResponse value,
          $Res Function(NewsGetOneModelResponse) then) =
      _$NewsGetOneModelResponseCopyWithImpl<$Res, NewsGetOneModelResponse>;
  @useResult
  $Res call({String message, NewsModel data});

  $NewsModelCopyWith<$Res> get data;
}

/// @nodoc
class _$NewsGetOneModelResponseCopyWithImpl<$Res,
        $Val extends NewsGetOneModelResponse>
    implements $NewsGetOneModelResponseCopyWith<$Res> {
  _$NewsGetOneModelResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? message = null,
    Object? data = null,
  }) {
    return _then(_value.copyWith(
      message: null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
      data: null == data
          ? _value.data
          : data // ignore: cast_nullable_to_non_nullable
              as NewsModel,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $NewsModelCopyWith<$Res> get data {
    return $NewsModelCopyWith<$Res>(_value.data, (value) {
      return _then(_value.copyWith(data: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$NewsGetOneModelResponseImplCopyWith<$Res>
    implements $NewsGetOneModelResponseCopyWith<$Res> {
  factory _$$NewsGetOneModelResponseImplCopyWith(
          _$NewsGetOneModelResponseImpl value,
          $Res Function(_$NewsGetOneModelResponseImpl) then) =
      __$$NewsGetOneModelResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String message, NewsModel data});

  @override
  $NewsModelCopyWith<$Res> get data;
}

/// @nodoc
class __$$NewsGetOneModelResponseImplCopyWithImpl<$Res>
    extends _$NewsGetOneModelResponseCopyWithImpl<$Res,
        _$NewsGetOneModelResponseImpl>
    implements _$$NewsGetOneModelResponseImplCopyWith<$Res> {
  __$$NewsGetOneModelResponseImplCopyWithImpl(
      _$NewsGetOneModelResponseImpl _value,
      $Res Function(_$NewsGetOneModelResponseImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? message = null,
    Object? data = null,
  }) {
    return _then(_$NewsGetOneModelResponseImpl(
      message: null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
      data: null == data
          ? _value.data
          : data // ignore: cast_nullable_to_non_nullable
              as NewsModel,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$NewsGetOneModelResponseImpl implements _NewsGetOneModelResponse {
  const _$NewsGetOneModelResponseImpl(
      {required this.message, required this.data});

  factory _$NewsGetOneModelResponseImpl.fromJson(Map<String, dynamic> json) =>
      _$$NewsGetOneModelResponseImplFromJson(json);

  @override
  final String message;
  @override
  final NewsModel data;

  @override
  String toString() {
    return 'NewsGetOneModelResponse(message: $message, data: $data)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$NewsGetOneModelResponseImpl &&
            (identical(other.message, message) || other.message == message) &&
            (identical(other.data, data) || other.data == data));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, message, data);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$NewsGetOneModelResponseImplCopyWith<_$NewsGetOneModelResponseImpl>
      get copyWith => __$$NewsGetOneModelResponseImplCopyWithImpl<
          _$NewsGetOneModelResponseImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$NewsGetOneModelResponseImplToJson(
      this,
    );
  }
}

abstract class _NewsGetOneModelResponse implements NewsGetOneModelResponse {
  const factory _NewsGetOneModelResponse(
      {required final String message,
      required final NewsModel data}) = _$NewsGetOneModelResponseImpl;

  factory _NewsGetOneModelResponse.fromJson(Map<String, dynamic> json) =
      _$NewsGetOneModelResponseImpl.fromJson;

  @override
  String get message;
  @override
  NewsModel get data;
  @override
  @JsonKey(ignore: true)
  _$$NewsGetOneModelResponseImplCopyWith<_$NewsGetOneModelResponseImpl>
      get copyWith => throw _privateConstructorUsedError;
}
