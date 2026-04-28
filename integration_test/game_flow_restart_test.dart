import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:tic_tac_toe/main.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('restart button appears when game ends and resets board', (tester) async {
    await tester.pumpWidget(
      const ProviderScope(child: MyApp()),
    );
    await tester.pumpAndSettle();

    await tester.tap(find.byKey(const Key('start_button')));
    await tester.pumpAndSettle();

    // Tap cells to drive the game to completion.
    // Minimax is deterministic; tapping corners forces AI to win quickly.
    const tapOrder = [0, 2, 6]; // player taps — AI plays optimally and will win
    for (final index in tapOrder) {
      final cell = find.byKey(Key('cell_$index'));
      if (cell.evaluate().isNotEmpty) {
        await tester.tap(cell);
        await tester.pumpAndSettle();
      }
      if (find.byKey(const Key('restart_button')).evaluate().isNotEmpty) break;
    }

    // If game hasn't ended yet, keep tapping available cells
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

    expect(find.byKey(const Key('board')), findsOneWidget);
    expect(find.byKey(const Key('restart_button')), findsNothing);
  });
}
