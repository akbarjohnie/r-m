import 'dart:convert';
import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:rick_and_morty/data/models/character/character.dart';

part 'favorites.g.dart';

abstract interface class IFavoritesLocalsource {
  const IFavoritesLocalsource();

  Future<void> saveCharater(CharacterModel character);
  Future<void> removeCharater(int id);

  Future<List<CharacterModel>> getFavorites();
}

// Конвертер для List<String>
class StringListConverter extends TypeConverter<List<String>, String> {
  const StringListConverter();
  @override
  List<String> fromSql(String fromDb) {
    return (json.decode(fromDb) as List<dynamic>).cast<String>();
  }

  @override
  String toSql(List<String> value) {
    return json.encode(value);
  }
}

class LocationConverter extends TypeConverter<CharacterLocationModel, String> {
  const LocationConverter();
  @override
  CharacterLocationModel fromSql(String fromDb) {
    return CharacterLocationModel.fromJson(json.decode(fromDb) as Map<String, dynamic>);
  }

  @override
  String toSql(CharacterLocationModel value) {
    return json.encode(value.toJson());
  }
}

class FavoriteCharacters extends Table {
  IntColumn get id => integer()();
  TextColumn get name => text()();
  TextColumn get status => text()();
  TextColumn get species => text()();
  TextColumn get type => text()();
  TextColumn get gender => text()();
  TextColumn get origin => text().map(const LocationConverter())();
  TextColumn get location => text().map(const LocationConverter())();
  TextColumn get image => text()();
  TextColumn get episode => text().map(const StringListConverter())();
  TextColumn get firstEpisodeName => text().nullable()();
  TextColumn get url => text()();
  TextColumn get created => text()();

  @override
  Set<Column> get primaryKey => {id};
}

@DriftDatabase(tables: [FavoriteCharacters])
class FavoritesDatabase extends _$FavoritesDatabase {
  FavoritesDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'favorites.db'));
    return NativeDatabase.createInBackground(file);
  });
}

final class FavoritesLocalsourceImpl implements IFavoritesLocalsource {
  const FavoritesLocalsourceImpl(this._db);

  final FavoritesDatabase _db;

  @override
  Future<void> saveCharater(CharacterModel character) async {
    final companion = FavoriteCharactersCompanion(
      id: Value(character.id),
      name: Value(character.name),
      status: Value(character.status),
      species: Value(character.species),
      type: Value(character.type),
      gender: Value(character.gender),
      origin: Value(character.origin),
      location: Value(character.location),
      image: Value(character.image),
      episode: Value(character.episode),
      firstEpisodeName: Value(character.firstEpisodeName),
      url: Value(character.url),
      created: Value(character.created),
    );
    await _db.into(_db.favoriteCharacters).insertOnConflictUpdate(companion);
  }

  @override
  Future<void> removeCharater(int id) async {
    await (_db.delete(_db.favoriteCharacters)..where((tbl) => tbl.id.equals(id))).go();
  }

  @override
  Future<List<CharacterModel>> getFavorites() async {
    final rows = await _db.select(_db.favoriteCharacters).get();
    return rows
        .map((row) => CharacterModel(
              id: row.id,
              name: row.name,
              status: row.status,
              species: row.species,
              type: row.type,
              gender: row.gender,
              origin: row.origin,
              location: row.location,
              image: row.image,
              episode: row.episode,
              firstEpisodeName: row.firstEpisodeName,
              url: row.url,
              created: row.created,
            ))
        .toList();
  }
}
