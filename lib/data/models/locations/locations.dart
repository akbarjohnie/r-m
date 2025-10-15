import 'package:freezed_annotation/freezed_annotation.dart';

part 'locations.freezed.dart';
part 'locations.g.dart';

@freezed
abstract class LocationsModel with _$LocationsModel {
  factory LocationsModel({
    required int id,
    required String name,
    required String type,
    required String dimension, required List<String> residents, required String url, required DateTime created, String? image,
  }) = _LocationsModel;

  factory LocationsModel.fromJson(Map<String, dynamic> json) => _$LocationsModelFromJson(json);
}
