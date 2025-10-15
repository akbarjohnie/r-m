import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:rick_and_morty/data/data.dart';
import 'package:rick_and_morty/domain/domain.dart';

part 'event.dart';
part 'state.dart';
part 'bloc.freezed.dart';

class FavoriteBloc extends Bloc<FavoriteEvent, FavoriteState> {
  FavoriteBloc(this._repository) : super(const FavoriteState()) {
    on<FavoriteEvent>(
      (event, emit) => switch (event) {
        _InitialEvent() => _onInitialEvent(event, emit),
        _ToggleFavoriteEvent() => _onToggleFavoriteEvent(event, emit),
      },
    );
  }

  final ICharactersRepository _repository;

  Future<void> _onInitialEvent(_InitialEvent event, Emitter<FavoriteState> emit) async {
    final res = await _repository.getFavorites();
    emit(state.copyWith(favoriteCharacters: res));
  }

  Future<void> _onToggleFavoriteEvent(_ToggleFavoriteEvent event, Emitter<FavoriteState> emit) async {
    final character = state.favoriteCharacters.firstWhere((e) => e.id == event.id);
    final updatedFavorites = [...state.favoriteCharacters];

    if (updatedFavorites.contains(character)) {
      await _repository.deleteFromFavorite(event.id).then((_) => updatedFavorites.remove(character));
    } else {
      await _repository.addToFavorite(character).then((_) => updatedFavorites.add(character));
    }

    emit(state.copyWith(favoriteCharacters: updatedFavorites));
  }
}
