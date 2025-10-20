import 'package:freezed_annotation/freezed_annotation.dart';

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
