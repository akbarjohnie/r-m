import 'package:rick_and_morty/data/data.dart';
import 'package:rick_and_morty/domain/domain.dart';

final class CharactersRepositoryImpl implements ICharactersRepository {
  const CharactersRepositoryImpl(
    this._datasourse,
    this._localSource,
  );

  final CharacterRemoteDatasourse _datasourse;
  final IFavoritesLocalsource _localSource;

  @override
  Future<(List<CharacterModel>, bool)> loadCharacters(int page) async {
    final pagination = await _datasourse.getCharacters(
      page: page,
    );

    final results = pagination.results;
    final loadNext = pagination.info.pages > page;

    return (results, loadNext);
  }

  @override
  Future<void> addToFavorite(CharacterModel character) => _localSource.saveCharater(character);

  @override
  Future<void> deleteFromFavorite(int id) => _localSource.removeCharater(id);

  @override
  Future<List<CharacterModel>> getFavorites() => _localSource.getFavorites();
}
