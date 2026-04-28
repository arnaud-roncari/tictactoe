import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:tic_tac_toe/main.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('home page shows Start button and navigates to game board', (tester) async {
    await tester.pumpWidget(
      const ProviderScope(child: MyApp()),
    );
    await tester.pumpAndSettle();

    expect(find.byKey(const Key('start_button')), findsOneWidget);

    await tester.tap(find.byKey(const Key('start_button')));
    await tester.pumpAndSettle();

    expect(find.byKey(const Key('board')), findsOneWidget);
    expect(find.byKey(const Key('cell_0')), findsOneWidget);
    expect(find.byKey(const Key('cell_8')), findsOneWidget);
  });
}
