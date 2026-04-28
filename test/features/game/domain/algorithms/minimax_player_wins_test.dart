import 'package:flutter_test/flutter_test.dart';
import 'package:tic_tac_toe/features/game/domain/algorithms/minimax.dart';

void main() {
  group('Minimax — player wins', () {
    test('detects X winning on top row', () {
      final board = ['X', 'X', 'X', 'O', 'O', null, null, null, null];
      expect(Minimax.checkWinner(board), equals('X'));
      expect(Minimax.getWinningLine(board), equals([0, 1, 2]));
    });

    test('detects X winning on left column', () {
      final board = ['X', 'O', null, 'X', 'O', null, 'X', null, null];
      expect(Minimax.checkWinner(board), equals('X'));
      expect(Minimax.getWinningLine(board), equals([0, 3, 6]));
    });

    test('AI does not pick invalid move when player wins', () {
      final board = List<String?>.filled(9, null);
      final move = Minimax.bestMove(board);
      expect(move, greaterThanOrEqualTo(0));
      expect(move, lessThan(9));
    });
  });
}
