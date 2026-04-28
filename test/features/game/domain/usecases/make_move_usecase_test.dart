import 'package:flutter_test/flutter_test.dart';
import 'package:tic_tac_toe/features/game/domain/entities/game_state.dart';
import 'package:tic_tac_toe/features/game/domain/enums/game_status.dart';
import 'package:tic_tac_toe/features/game/domain/enums/player.dart';
import 'package:tic_tac_toe/features/game/domain/usecases/make_move_usecase.dart';

void main() {
  const useCase = MakeMoveUseCase();

  GameState playingState({List<String?>? board}) => GameState(
        board: board ?? List.filled(9, null),
        currentPlayer: Player.x,
        startingPlayer: Player.x,
        status: GameStatus.playing,
      );

  group('MakeMoveUseCase — guard clauses', () {
    test('ignores move when game is not playing', () {
      final state = playingState().copyWith(status: GameStatus.playerWin);
      expect(useCase(state, 0), same(state));
    });

    test('ignores move when cell is already occupied', () {
      final state = playingState(board: ['X', null, null, null, null, null, null, null, null]);
      expect(useCase(state, 0), same(state));
    });
  });

  group('MakeMoveUseCase — game outcomes', () {
    test('detects player win and returns playerWin status', () {
      // X has [0,1], plays 2 → wins top row
      final state = playingState(
        board: ['X', 'X', null, 'O', 'O', null, null, null, null],
      );
      final result = useCase(state, 2);
      expect(result.status, GameStatus.playerWin);
      expect(result.winningCells, containsAll([0, 1, 2]));
    });

    test('preserves startingPlayer through moves', () {
      final state = playingState();
      final result = useCase(state, 0);
      expect(result.startingPlayer, Player.x);
    });

    test('returns playing status when game continues', () {
      final state = playingState();
      final result = useCase(state, 0);
      expect(result.status, GameStatus.playing);
      expect(result.board[0], 'X');
    });

    test('AI responds after player move', () {
      final state = playingState();
      final result = useCase(state, 0);
      // Both X and O must appear on the board after one round.
      expect(result.board.where((c) => c == 'X').length, 1);
      expect(result.board.where((c) => c == 'O').length, 1);
    });
  });
}
