part of 'bloc.dart';

@freezed
sealed class FavoriteEvent with _$FavoriteEvent {
  const factory FavoriteEvent.initial() = _InitialEvent;

  const factory FavoriteEvent.toggleFavorite(int id) = _ToggleFavoriteEvent;

}