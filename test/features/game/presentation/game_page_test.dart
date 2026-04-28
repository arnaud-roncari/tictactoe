import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tic_tac_toe/core/l10n/app_localizations.dart';
import 'package:tic_tac_toe/features/game/data/repositories/starting_player_repository_impl.dart';
import 'package:tic_tac_toe/features/game/domain/enums/player.dart';
import 'package:tic_tac_toe/features/game/presentation/pages/game_page.dart';
import '../../../mocks/repositories/starting_player_repository_mock.dart';

Widget _buildGamePage({Player initial = Player.x}) {
  return ProviderScope(
    overrides: [
      startingPlayerRepositoryProvider.overrideWithValue(
        StartingPlayerRepositoryMock(initial: initial),
      ),
    ],
    child: MaterialApp(
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      home: const GamePage(),
    ),
  );
}

void main() {
  group('GamePage — board', () {
    testWidgets('renders 9 cells on start', (tester) async {
      await tester.pumpWidget(_buildGamePage());
      await tester.pumpAndSettle();

      expect(find.byKey(const Key('board')), findsOneWidget);
      for (int i = 0; i < 9; i++) {
        expect(find.byKey(Key('cell_$i')), findsOneWidget);
      }
    });

    testWidgets('no restart button while game is in progress', (tester) async {
      await tester.pumpWidget(_buildGamePage());
      await tester.pumpAndSettle();

      expect(find.byKey(const Key('restart_button')), findsNothing);
    });

    testWidgets('tapping a cell places X on the board', (tester) async {
      await tester.pumpWidget(_buildGamePage());
      await tester.pumpAndSettle();

      await tester.tap(find.byKey(const Key('cell_0')));
      await tester.pumpAndSettle();

      expect(find.text('X'), findsOneWidget);
    });
  });

  group('GamePage — restart', () {
    testWidgets('restart button appears after game ends and resets board', (tester) async {
      await tester.pumpWidget(_buildGamePage());
      await tester.pumpAndSettle();

      // Tap cells until game ends (AI is unbeatable — it will win or draw).
      for (int i = 0; i < 9; i++) {
        if (find.byKey(const Key('restart_button')).evaluate().isNotEmpty) break;
        final cell = find.byKey(Key('cell_$i'));
        if (cell.evaluate().isNotEmpty) {
          await tester.tap(cell);
          await tester.pumpAndSettle();
        }
      }

      expect(find.byKey(const Key('restart_button')), findsOneWidget);

      await tester.tap(find.byKey(const Key('restart_button')));
      await tester.pumpAndSettle();

      expect(find.byKey(const Key('restart_button')), findsNothing);
    });
  });
}
