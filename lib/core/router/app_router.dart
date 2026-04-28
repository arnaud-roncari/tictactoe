import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../features/game/presentation/pages/game_page.dart';
import '../../features/home/presentation/pages/home_page.dart';
import '../../features/not_found/presentation/pages/not_found_page.dart';
import '../constants/app_routes.dart';

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
