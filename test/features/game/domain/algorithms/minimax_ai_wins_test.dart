import 'package:flutter_test/flutter_test.dart';
import 'package:tic_tac_toe/features/game/domain/algorithms/minimax.dart';

void main() {
  group('Minimax — AI wins', () {
    test('detects O winning on middle row', () {
      final board = ['X', null, 'X', 'O', 'O', 'O', null, null, null];
      expect(Minimax.checkWinner(board), equals('O'));
      expect(Minimax.getWinningLine(board), equals([3, 4, 5]));
    });

    test('detects O winning on diagonal', () {
      final board = ['O', 'X', null, 'X', 'O', null, null, null, 'O'];
      expect(Minimax.checkWinner(board), equals('O'));
      expect(Minimax.getWinningLine(board), equals([0, 4, 8]));
    });

    test('AI picks the winning move when available', () {
      final board = ['O', 'O', null, 'X', 'X', null, null, null, null];
      expect(Minimax.bestMove(board), equals(2));
    });

    test('AI blocks player from winning', () {
      final board = ['X', 'X', null, 'O', null, null, null, null, null];
      expect(Minimax.bestMove(board), equals(2));
    });
  });
}
