import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

abstract class HomeNavItem {
  const HomeNavItem({
    required this.iconBuilder,
    required this.routePath,
  });

  final Widget Function(bool isActive) iconBuilder;
  final String routePath;

  void navigate(BuildContext ctx, {String? selectedPath}) {
    ctx.router.navigateNamed(
      '/home/$routePath',
    );
  }
}

class CharactersNavItem extends HomeNavItem {
  CharactersNavItem()
      : super(
          iconBuilder: (_) => const Icon(
            Icons.home_outlined,
          ),
          routePath: 'characters',
        );
}

class FavoritesManagerItem extends HomeNavItem {
  FavoritesManagerItem()
      : super(
          iconBuilder: (_) => const Icon(
            Icons.favorite,
          ),
          routePath: 'favorites',
        );
}
