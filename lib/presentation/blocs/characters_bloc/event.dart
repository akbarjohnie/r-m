part of 'bloc.dart';

@freezed
sealed class CharactersEvent with _$CharactersEvent {
  const factory CharactersEvent.initial() = _InitialEvent;
  const factory CharactersEvent.loadNextCharactersPage() = _LoadNextCharactersEvent;

  const factory CharactersEvent.toggleFavorite(int id) = _ToggleFavoriteEvent;
}