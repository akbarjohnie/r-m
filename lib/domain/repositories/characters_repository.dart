import 'package:rick_and_morty/data/data.dart';

abstract interface class ICharactersRepository {
  Future<(List<CharacterModel>, bool)> loadCharacters(int page);

  Future<void> addToFavorite(CharacterModel character);
  Future<void> deleteFromFavorite(int id);
}