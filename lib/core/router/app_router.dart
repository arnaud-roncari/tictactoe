import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:tic_tac_toe/core/constants/app_routes.dart';
import 'package:tic_tac_toe/features/game/presentation/pages/game_page.dart';
import 'package:tic_tac_toe/features/home/presentation/pages/home_page.dart';
import 'package:tic_tac_toe/features/not_found/presentation/pages/not_found_page.dart';

part 'app_router.g.dart';

/// Provides the application's [GoRouter] instance as a Riverpod provider.
///
/// Route constants are declared in [AppRoutes].
/// Unknown routes fall back to [NotFoundPage].
@Riverpod(keepAlive: true)
GoRouter appRouter(AppRouterRef ref) {
  return GoRouter(
    initialLocation: AppRoutes.home,
    errorBuilder: (context, state) => const NotFoundPage(),
    routes: [
      GoRoute(
        path: AppRoutes.home,
        builder: (context, state) => const HomePage(),
      ),
      GoRoute(
        path: AppRoutes.game,
        builder: (context, state) => const GamePage(),
      ),
    ],
  );
}
