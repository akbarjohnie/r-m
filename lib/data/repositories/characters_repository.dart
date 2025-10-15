import 'package:rick_and_morty/data/data.dart';
import 'package:rick_and_morty/domain/domain.dart';

final class CharactersRepositoryImpl implements ICharactersRepository {
  const CharactersRepositoryImpl(
    this._datasourse,
  );

  final CharacterRemoteDatasourse _datasourse;

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
  Future<void> addToFavorite(CharacterModel character) {
    // TODO: implement addToFavorite
    throw UnimplementedError();
  }
  
  @override
  Future<void> deleteFromFavorite(int id) {
    // TODO: implement deleteFromFavorite
    throw UnimplementedError();
  }
}
