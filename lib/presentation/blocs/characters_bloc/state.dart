part of 'bloc.dart';

class CharactersState extends Equatable {
  const CharactersState({
    this.nextPage = 1,
    this.loadNext = false,
    this.characters = const [],
    this.favorites = const [],
  });

  final int nextPage;
  final bool loadNext;

  final List<CharacterModel> characters;

  final List<int> favorites;

  CharactersState copyWith({
    int? nextPage,
    bool? loadNext,
    List<CharacterModel>? characters,
    List<int>? favorites,
  }) =>
      CharactersState(
        nextPage: nextPage ?? this.nextPage,
        loadNext: loadNext ?? this.loadNext,
        characters: characters ?? this.characters,
        favorites: favorites ?? this.favorites,
      );

  @override
  List<Object?> get props => [
        nextPage,
        loadNext,
        characters,
        favorites,
      ];
}
