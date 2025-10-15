import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:rick_and_morty/data/data.dart';

part 'event.dart';
part 'state.dart';
part 'bloc.freezed.dart';

class FavoriteBloc extends Bloc<FavoriteEvent, FavoriteState> {
  FavoriteBloc() : super(const FavoriteState()) {
    on<FavoriteEvent>(
      (event, emit) => switch (event) {
        _InitialEvent() => _onInitialEvent(event, emit),
        _ToggleFavoriteEvent() => _onToggleFavoriteEvent(event, emit),
      },
    );
  }

  Future<void> _onInitialEvent(_InitialEvent event, Emitter<FavoriteState> emit) async {}

  Future<void> _onToggleFavoriteEvent(_ToggleFavoriteEvent event, Emitter<FavoriteState> emit) async {}
}
