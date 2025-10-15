import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_and_morty/app.dart';
import 'package:rick_and_morty/core/bloc/bloc_observer.dart';
import 'package:rick_and_morty/core/di/dependencies_provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  Bloc.observer = const AppBlocObserver();

  runApp(const DependenciesProvider(
    child: RickAndMortyApp(),
  ));
}
