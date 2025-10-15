import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_and_morty/common/common.dart';
import 'package:rick_and_morty/core/core.dart';
import 'package:rick_and_morty/presentation/blocs/blocs.dart';
import 'package:rick_and_morty/presentation/pages/widgets/widgets.dart';

@RoutePage()
class CharactersPage extends StatefulWidget implements AutoRouteWrapper {
  const CharactersPage({super.key});

  @override
  State<CharactersPage> createState() => _CharactersPageState();

  @override
  Widget wrappedRoute(BuildContext context) {
    return BlocProvider(
      create: (context) => CharactersBloc(
        context.read(),
      )..add(const CharactersEvent.initial()),
      child: this,
    );
  }
}

class _CharactersPageState extends State<CharactersPage> {
  final ScrollController _scrollController = ScrollController();

  CharactersBloc get _pageBloc => context.read<CharactersBloc>();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController
      ..removeListener(_onScroll)
      ..dispose();
    super.dispose();
  }

  void _onScroll() {
    if (!_pageBloc.state.loadNext) return;

    if (_scrollController.position.pixels >= _scrollController.position.maxScrollExtent * 0.6) {
      _pageBloc.add(const CharactersEvent.loadNextCharactersPage());
    }
  }

  void _onFavoriteTap(int id) => _pageBloc.add(CharactersEvent.toggleFavorite(id));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Персонажи'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: BlocBuilder<CharactersBloc, CharactersState>(
          buildWhen: (p, c) => p.characters != c.characters || p.loadNext != c.loadNext,
          builder: (context, state) {
            if (state.characters.isEmpty) return const Center(child: CircularProgressIndicator());

            return ListView.separated(
              controller: _scrollController,
              padding: const P(horizontal: 24),
              itemCount: state.characters.length,
              separatorBuilder: (_, __) => const SizedBox(height: 16),
              itemBuilder: (context, index) => BlocBuilder<CharactersBloc, CharactersState>(
                buildWhen: (p, c) => p.favorites != c.favorites,
                builder: (context, state) => CharacterCard.fromModel(
                  model: state.characters[index],
                  onFavoriteTap: _onFavoriteTap,
                  isFavorite: state.favorites.contains(state.characters[index].id),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
