import 'package:freezed_annotation/freezed_annotation.dart';

part 'episodes.freezed.dart';
part 'episodes.g.dart';

@freezed
abstract class EpisodesModel with _$EpisodesModel {
  factory EpisodesModel({
    required int id,
    required String name,
    required String airDate,
    required String episode,
    required List<String> characters,
    required String url,
    required DateTime created,
  }) = _EpisodesModel;

  factory EpisodesModel.fromJson(Map<String, dynamic> json) => _$EpisodesModelFromJson(json);
}
