import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tic_tac_toe/features/game/data/repositories/starting_player_repository_impl.dart';
import 'package:tic_tac_toe/features/game/domain/enums/game_status.dart';
import 'package:tic_tac_toe/features/game/domain/enums/player.dart';
import 'package:tic_tac_toe/features/game/presentation/notifiers/game_notifier.dart';
import '../../../mocks/repositories/starting_player_repository_mock.dart';

ProviderContainer _makeContainer({Player initial = Player.x}) {
  return ProviderContainer(
    overrides: [
      startingPlayerRepositoryProvider.overrideWithValue(
        StartingPlayerRepositoryMock(initial: initial),
      ),
    ],
  );
}

void main() {
  group('GameNotifier — initial state', () {
    test('player starts when repository returns Player.x', () {
      final state = _makeContainer().read(gameNotifierProvider);

      expect(state.startingPlayer, Player.x);
      expect(state.currentPlayer, Player.x);
      expect(state.status, GameStatus.playing);
      expect(state.board.every((c) => c == null), isTrue);
    });

    test('AI starts when repository returns Player.o — board has one O', () {
      final state = _makeContainer(initial: Player.o).read(gameNotifierProvider);

      expect(state.startingPlayer, Player.o);
      expect(state.currentPlayer, Player.x);
      expect(state.board.where((c) => c == 'O').length, 1);
      expect(state.board.where((c) => c == 'X').length, 0);
    });
  });

  group('GameNotifier — restart', () {
    test('alternates starting player from x to o', () async {
      final container = _makeContainer(initial: Player.x);
      await container.read(gameNotifierProvider.notifier).restart();

      final state = container.read(gameNotifierProvider);
      expect(state.startingPlayer, Player.o);
      expect(state.board.where((c) => c == 'O').length, 1);
    });

    test('alternates starting player from o to x', () async {
      final container = _makeContainer(initial: Player.o);
      await container.read(gameNotifierProvider.notifier).restart();

      final state = container.read(gameNotifierProvider);
      expect(state.startingPlayer, Player.x);
      expect(state.board.every((c) => c == null), isTrue);
    });

    test('resets board and status', () async {
      final container = _makeContainer();
      container.read(gameNotifierProvider.notifier).makeMove(0);
      await container.read(gameNotifierProvider.notifier).restart();

      final state = container.read(gameNotifierProvider);
      expect(state.status, GameStatus.playing);
      expect(state.winningCells, isEmpty);
    });
  });
}
