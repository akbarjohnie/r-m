import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_and_morty/common/common.dart';
import 'package:rick_and_morty/presentation/blocs/blocs.dart';
import 'package:rick_and_morty/presentation/pages/widgets/widgets.dart';

@RoutePage()
class FavoritesPage extends StatelessWidget implements AutoRouteWrapper {
  const FavoritesPage({super.key});

  @override
  Widget wrappedRoute(BuildContext context) {
    return BlocProvider(
      create: (context) => FavoriteBloc(
        context.read(),
      )..add(const FavoriteEvent.initial()),
      child: this,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Избранное'),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: SafeArea(
        child: BlocBuilder<FavoriteBloc, FavoriteState>(
          buildWhen: (p, c) => p.favoriteCharacters != c.favoriteCharacters,
          builder: (context, state) {
            if (state.favoriteCharacters.isEmpty) {
              return const Center(child: Text('Тут пусто. Добавьте персонажей в избранное'));
            }

            return ListView.separated(
              padding: const P(horizontal: 24),
              itemCount: state.favoriteCharacters.length,
              itemBuilder: (context, index) => CharacterCard.fromModel(
                model: state.favoriteCharacters[index],
                isFavorite: true,
                onFavoriteTap: (id) {
                  context.read<FavoriteBloc>().add(FavoriteEvent.toggleFavorite(id));
                },
              ),
              separatorBuilder: (_, __) => const SizedBox(height: 16),
            );
          },
        ),
      ),
    );
  }
}
