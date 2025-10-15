part of 'bloc.dart';

class FavoriteState extends Equatable {
  const FavoriteState({
    this.favoriteCharacters = const [],
  });

  final List<CharacterModel> favoriteCharacters;

  FavoriteState copyWith({
    List<CharacterModel>? favoriteCharacters,
  }) =>
      FavoriteState(
        favoriteCharacters: favoriteCharacters ?? this.favoriteCharacters,
      );

  @override
  List<Object?> get props => [
        favoriteCharacters,
      ];
}
