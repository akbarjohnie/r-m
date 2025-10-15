import 'dart:convert';
import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
import 'package:rick_and_morty/data/models/character/character.dart';

part 'characters_db.g.dart';

class CharactersTable extends Table {
  IntColumn get id => integer()();
  TextColumn get name => text()();
  TextColumn get status => text()();
  TextColumn get species => text()();
  TextColumn get type => text()();
  TextColumn get gender => text()();
  TextColumn get origin => text().map(const _LocationConverter())();
  TextColumn get location => text().map(const _LocationConverter())();
  TextColumn get image => text()();
  TextColumn get episode => text().map(const _StringListConverter())();
  TextColumn get firstEpisodeName => text().nullable()();
  TextColumn get url => text()();
  TextColumn get created => text()();

  @override
  Set<Column> get primaryKey => {id};
}

// Таблица для метаданных
class Metadatas extends Table {
  IntColumn get id => integer()();
  IntColumn get count => integer()();
  IntColumn get pages => integer()();

  @override
  Set<Column> get primaryKey => {id};
}

// Класс базы данных
@DriftDatabase(tables: [CharactersTable, Metadatas])
class CharactersDatabase extends _$CharactersDatabase {
  CharactersDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'cached_characters.db'));
    return NativeDatabase.createInBackground(file);
  });
}

class _StringListConverter extends TypeConverter<List<String>, String> {
  const _StringListConverter();
  @override
  List<String> fromSql(String fromDb) {
    return (json.decode(fromDb) as List<dynamic>).cast<String>();
  }

  @override
  String toSql(List<String> value) {
    return json.encode(value);
  }
}

class _LocationConverter extends TypeConverter<CharacterLocationModel, String> {
  const _LocationConverter();
  @override
  CharacterLocationModel fromSql(String fromDb) {
    return CharacterLocationModel.fromJson(json.decode(fromDb) as Map<String, dynamic>);
  }

  @override
  String toSql(CharacterLocationModel value) {
    return json.encode(value.toJson());
  }
}
