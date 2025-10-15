import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// ignore: depend_on_referenced_packages
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:provider/provider.dart';
import 'package:rick_and_morty/data/data.dart';
import 'package:rick_and_morty/domain/domain.dart';

class DependenciesProvider extends StatelessWidget {
  const DependenciesProvider({
    super.key,
    this.child,
  });

  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        RepositoryProvider(
          create: (context) => Dio()
            ..interceptors.addAll([
              if (kDebugMode) PrettyDioLogger(),
            ])
            ..options.baseUrl = 'https://rickandmortyapi.com',
        ),
        RepositoryProvider(
          create: (context) => CharacterRemoteDatasourse(context.read<Dio>()),
          lazy: false,
        ),
        RepositoryProvider(
          create: (context) => EpisodesRemoteDatasourse(context.read<Dio>()),
        ),
        RepositoryProvider(
          create: (context) => LocationsRemoteDatasourse(context.read<Dio>()),
        ),
        RepositoryProvider<ICharactersRepository>(
          create: (context) => CharactersRepositoryImpl(context.read()),
        ),
        RepositoryProvider<ILocationsRepository>(
          create: (context) => const LocationsRepositoryImpl(),
        ),
        RepositoryProvider<IEpisodesRepository>(
          create: (context) => const EpisodesRepositoryImpl(),
        ),
      ],
      child: child,
    );
  }
}
