import 'package:freezed_annotation/freezed_annotation.dart';

part 'character.freezed.dart';

part 'character.g.dart';

@freezed
abstract class CharacterModel with _$CharacterModel {
  const factory CharacterModel({
    required int id,
    required String name,
    required String status,
    required String species,
    required String type,
    required String gender,
    required CharacterLocationModel origin,
    required CharacterLocationModel location,
    required String image,
    required List<String> episode,
    required String? firstEpisodeName,
    required String url,
    required String created,
  }) = _CharacterModel;

  factory CharacterModel.fromJson(Map<String, dynamic> json) => _$CharacterModelFromJson(json);
}

@freezed
abstract class CharacterLocationModel with _$CharacterLocationModel {
  factory CharacterLocationModel({
    required String name,
    required String url,
  }) = _CharacterLocationModel;

  factory CharacterLocationModel.fromJson(Map<String, dynamic> json) => _$CharacterLocationModelFromJson(json);
}

enum CharacterStatus {
  @JsonValue('alive')
  alive,
  @JsonValue('unknown')
  unknown,
  @JsonValue('dead')
  dead,
  @JsonValue('')
  empty;
}

enum CharacterGender {
  @JsonValue('male')
  male,
  @JsonValue('female')
  female,
  @JsonValue('unknown')
  unknown,
  @JsonValue('genderless')
  genderless,
}
