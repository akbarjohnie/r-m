import 'package:json_annotation/json_annotation.dart';

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
