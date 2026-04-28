import 'package:flutter_test/flutter_test.dart';
import 'package:tic_tac_toe/features/game/domain/enums/game_status.dart';
import 'package:tic_tac_toe/features/game/domain/enums/player.dart';
import 'package:tic_tac_toe/features/game/domain/usecases/init_game_usecase.dart';
import '../../../../mocks/repositories/starting_player_repository_mock.dart';

void main() {
  group('InitGameUseCase — player starts', () {
    test('returns empty board when Player.x starts', () {
      final useCase = InitGameUseCase(StartingPlayerRepositoryMock(initial: Player.x));
      final state = useCase();

      expect(state.startingPlayer, Player.x);
      expect(state.currentPlayer, Player.x);
      expect(state.status, GameStatus.playing);
      expect(state.board.every((c) => c == null), isTrue);
      expect(state.winningCells, isEmpty);
    });
  });

  group('InitGameUseCase — AI starts', () {
    test('AI plays its opening move when Player.o starts', () {
      final useCase = InitGameUseCase(StartingPlayerRepositoryMock(initial: Player.o));
      final state = useCase();

      expect(state.startingPlayer, Player.o);
      expect(state.currentPlayer, Player.x);
      expect(state.status, GameStatus.playing);
      expect(state.board.where((c) => c == 'O').length, 1);
      expect(state.board.where((c) => c == 'X').length, 0);
    });

    test('AI opening move is within valid cell range', () {
      final useCase = InitGameUseCase(StartingPlayerRepositoryMock(initial: Player.o));
      final state = useCase();
      final aiCell = state.board.indexWhere((c) => c == 'O');

      expect(aiCell, greaterThanOrEqualTo(0));
      expect(aiCell, lessThan(9));
    });
  });
}
