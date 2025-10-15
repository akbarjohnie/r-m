import 'package:rick_and_morty/data/data.dart';
import 'package:rick_and_morty/domain/domain.dart';

final class CharactersRepositoryImpl implements ICharactersRepository {
  const CharactersRepositoryImpl(
    this._datasourse,
    this._favoritesSource,
    this._charactersSource,
  );

  final CharacterRemoteDatasourse _datasourse;
  final IFavoritesLocalsource _favoritesSource;
  final ICharactersLocalSource _charactersSource;

  @override
  Future<(List<CharacterModel>, bool)> loadCharacters(int page) async {
    final metadata = await _charactersSource.getMetadata();
    if (metadata != null) {
      final characters = await _charactersSource.getCharactersForPage(page);
      const perPage = 20;
      final expected =
          (page < metadata.pages) ? perPage : (metadata.count % perPage == 0 ? perPage : metadata.count % perPage);
      if (characters.length == expected) {
        return (characters, page < metadata.pages);
      }
    }

    final pagination = await _datasourse.getCharacters(
      page: page,
    );

    await _charactersSource.saveMetadata(pagination.info);
    await _charactersSource.saveCharacters(pagination.results);

    final results = pagination.results;
    final loadNext = pagination.info.pages > page;

    return (results, loadNext);
  }

  @override
  Future<void> addToFavorite(CharacterModel character) => _favoritesSource.saveCharater(character);

  @override
  Future<void> deleteFromFavorite(int id) => _favoritesSource.removeCharater(id);

  @override
  Future<List<CharacterModel>> getFavorites() => _favoritesSource.getFavorites();
}
