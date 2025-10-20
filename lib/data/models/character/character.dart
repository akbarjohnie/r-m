import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:rick_and_morty/data/models/models.dart';

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
