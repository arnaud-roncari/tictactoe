import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tic_tac_toe/features/game/data/datasources/local_storage_datasource_impl.dart';
import 'package:tic_tac_toe/features/game/data/repositories/starting_player_repository_impl.dart';
import 'package:tic_tac_toe/main.dart';
import 'mocks/datasources/local_storage_datasource_mock.dart';
import 'mocks/repositories/starting_player_repository_mock.dart';

void main() {
  testWidgets('App renders home page without crashing', (WidgetTester tester) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          localStorageDatasourceProvider.overrideWithValue(LocalStorageDatasourceMock()),
          startingPlayerRepositoryProvider.overrideWithValue(StartingPlayerRepositoryMock()),
        ],
        child: const MyApp(),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.byKey(const Key('start_button')), findsOneWidget);
  });
}
