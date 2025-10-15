import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:rick_and_morty/core/core.dart';
import 'package:rick_and_morty/data/data.dart';
import 'package:rick_and_morty/domain/domain.dart';

part 'event.dart';
part 'state.dart';
part 'bloc.freezed.dart';

class CharactersBloc extends Bloc<CharactersEvent, CharactersState> {
  CharactersBloc(
    this._repository,
  ) : super(const CharactersState()) {
    on<CharactersEvent>(
      (event, emit) => switch (event) {
        _InitialEvent() => _onInitialEvent(event, emit),
        _LoadNextCharactersEvent() => _onLoadNextCharactersEvent(event, emit),
        _ToggleFavoriteEvent() => _onToggleFavoriteEvent(event, emit),
      },
    );
  }

  final ICharactersRepository _repository;

  Future<void> _onInitialEvent(_InitialEvent event, Emitter<CharactersState> emit) async {
    final res = await _repository.loadCharacters(1);
    emit(state.copyWith(
      nextPage: state.nextPage + 1,
      characters: res.$1,
      loadNext: res.$2,
    ));
  }

  Future<void> _onLoadNextCharactersEvent(_LoadNextCharactersEvent event, Emitter<CharactersState> emit) async {
    if (!state.loadNext) return;
    emit(state.copyWith(loadNext: false));

    final res = await _repository.loadCharacters(state.nextPage);

    emit(state.copyWith(
      characters: [...state.characters, ...res.$1],
      nextPage: state.nextPage + 1,
      loadNext: res.$2,
    ));
  }

  Future<void> _onToggleFavoriteEvent(_ToggleFavoriteEvent event, Emitter<CharactersState> emit) async {
    final character = state.characters.firstWhere((e) => e.id == event.id);
    final updatedFavorites = [...state.favorites];

    if (updatedFavorites.contains(event.id)) {
      await _repository.deleteFromFavorite(event.id).then((_) => updatedFavorites.remove(event.id));
    } else {
      await _repository.addToFavorite(character).then((_) => updatedFavorites.add(event.id));
    }

    emit(state.copyWith(favorites: updatedFavorites));
  }
}
