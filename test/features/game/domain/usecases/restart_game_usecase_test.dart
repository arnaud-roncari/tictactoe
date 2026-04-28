import 'package:flutter_test/flutter_test.dart';
import 'package:tic_tac_toe/features/game/domain/entities/game_state.dart';
import 'package:tic_tac_toe/features/game/domain/enums/game_status.dart';
import 'package:tic_tac_toe/features/game/domain/enums/player.dart';
import 'package:tic_tac_toe/features/game/domain/usecases/init_game_usecase.dart';
import 'package:tic_tac_toe/features/game/domain/usecases/restart_game_usecase.dart';
import 'package:tic_tac_toe/features/game/domain/usecases/set_starting_player_usecase.dart';
import '../../../../mocks/repositories/starting_player_repository_mock.dart';

RestartGameUseCase _makeUseCase(StartingPlayerRepositoryMock repo) {
  return RestartGameUseCase(
    SetStartingPlayerUseCase(repo),
    InitGameUseCase(repo),
  );
}

GameState _stateWith(Player startingPlayer) => GameState(
      board: List.filled(9, null),
      currentPlayer: Player.x,
      startingPlayer: startingPlayer,
      status: GameStatus.playing,
    );

void main() {
  group('RestartGameUseCase — starting player alternation', () {
    test('alternates from Player.x to Player.o', () async {
      final repo = StartingPlayerRepositoryMock(initial: Player.x);
      final result = await _makeUseCase(repo)(_stateWith(Player.x));

      expect(result.startingPlayer, Player.o);
      // AI played its opening move.
      expect(result.board.where((c) => c == 'O').length, 1);
    });

    test('alternates from Player.o to Player.x', () async {
      final repo = StartingPlayerRepositoryMock(initial: Player.o);
      final result = await _makeUseCase(repo)(_stateWith(Player.o));

      expect(result.startingPlayer, Player.x);
      expect(result.board.every((c) => c == null), isTrue);
    });

    test('persists the new starting player in the repository', () async {
      final repo = StartingPlayerRepositoryMock(initial: Player.x);
      await _makeUseCase(repo)(_stateWith(Player.x));

      expect(repo.getStartingPlayer(), Player.o);
    });
  });

  group('RestartGameUseCase — reset', () {
    test('always returns a fresh board and playing status', () async {
      final repo = StartingPlayerRepositoryMock(initial: Player.o);
      final dirty = GameState(
        board: ['X', 'O', 'X', null, null, null, null, null, null],
        currentPlayer: Player.x,
        startingPlayer: Player.o,
        status: GameStatus.aiWin,
        winningCells: [0, 1, 2],
      );
      final result = await _makeUseCase(repo)(dirty);

      expect(result.status, GameStatus.playing);
      expect(result.winningCells, isEmpty);
      expect(result.startingPlayer, Player.x);
    });
  });
}
