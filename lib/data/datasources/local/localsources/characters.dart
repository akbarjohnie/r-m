import 'package:drift/drift.dart';
import 'package:rick_and_morty/data/data.dart';
import 'package:rick_and_morty/data/datasources/local/databases/db.dart';

abstract interface class ICharactersLocalSource {
  const ICharactersLocalSource();

  Future<void> saveCharacters(List<CharacterModel> characters);
  Future<List<CharacterModel>> getCharactersForPage(int page);
  Future<void> saveMetadata(InfoModel info);
  Future<InfoModel?> getMetadata();
}

final class CharactersLocalSourceImpl implements ICharactersLocalSource {
  const CharactersLocalSourceImpl(this._db);

  final CharactersDatabase _db;

  @override
  Future<void> saveCharacters(List<CharacterModel> characters) async {
    await _db.batch((batch) {
      batch.insertAllOnConflictUpdate(
        _db.charactersTable,
        characters.map((character) => CharactersTableCompanion(
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
            )),
      );
    });
  }

  @override
  Future<List<CharacterModel>> getCharactersForPage(int page) async {
    const perPage = 20;
    final startId = (page - 1) * perPage + 1;
    final endId = page * perPage;

    final query = _db.select(_db.charactersTable)
      ..where((tbl) => tbl.id.isBetweenValues(startId, endId))
      ..orderBy([(tbl) => OrderingTerm(expression: tbl.id)]);

    final rows = await query.get();
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

  @override
  Future<void> saveMetadata(InfoModel info) async {
    final companion = MetadatasCompanion(
      id: const Value(1),
      count: Value(info.count),
      pages: Value(info.pages),
    );
    await _db.into(_db.metadatas).insertOnConflictUpdate(companion);
  }

  @override
  Future<InfoModel?> getMetadata() async {
    final row = await (_db.select(_db.metadatas)..where((tbl) => tbl.id.equals(1))).getSingleOrNull();
    if (row == null) return null;
    return InfoModel(
      count: row.count,
      pages: row.pages,
    );
  }
}
