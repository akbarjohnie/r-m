import 'dart:convert';
import 'package:drift/drift.dart';
import 'package:rick_and_morty/data/models/character/character.dart';

class LocationConverter extends TypeConverter<CharacterLocationModel, String> {
  const LocationConverter();
  @override
  CharacterLocationModel fromSql(String fromDb) =>
      CharacterLocationModel.fromJson(json.decode(fromDb) as Map<String, dynamic>);

  @override
  String toSql(CharacterLocationModel value) => json.encode(value.toJson());
}
