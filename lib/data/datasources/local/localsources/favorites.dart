import 'package:drift/drift.dart';
import 'package:rick_and_morty/data/datasources/local/databases/db.dart';
import 'package:rick_and_morty/data/models/character/character.dart';

abstract interface class IFavoritesLocalsource {
  const IFavoritesLocalsource();

  Future<void> saveCharater(CharacterModel character);
  Future<void> removeCharater(int id);

  Future<List<CharacterModel>> getFavorites();
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
