import 'package:auto_route/auto_route.dart';
import 'package:rick_and_morty/presentation/pages/pages.dart';

part 'router.gr.dart';

@AutoRouterConfig()
class AppRouter extends RootStackRouter {
  @override
  List<AutoRoute> get routes => [
        AutoRoute(
          page: HomeRoute.page,
          path: '/home',
          initial: true,
          children: [
            AutoRoute(
              page: CharactersRoute.page,
              path: 'characters',
              initial: true,
            ),
            AutoRoute(
              page: FavoritesRoute.page,
              path: 'favorites',
            ),
          ],
        ),
      ];
}
