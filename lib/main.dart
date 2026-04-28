import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'core/design_system/app_theme.dart';
import 'core/l10n/app_localizations.dart';
import 'core/observer/riverpod_observer.dart';
import 'core/router/app_router.dart';
import 'features/game/data/datasources/local_storage_datasource_impl.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // SharedPreferences loads all values into memory once — reads become synchronous.
  final prefs = await SharedPreferences.getInstance();

  runApp(
    ProviderScope(
      overrides: [
        localStorageDatasourceProvider.overrideWithValue(
          LocalStorageDatasourceImpl(prefs),
        ),
      ],
      observers: [RiverpodObserver()],
      child: const MyApp(),
    ),
  );
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(appRouterProvider);
    return MaterialApp.router(
      title: 'TicTacToe',
      theme: AppTheme.data,
      routerConfig: router,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
    );
  }
}
