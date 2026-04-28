import 'dart:math';

/// Minimax algorithm for TicTacToe.
///
/// The board is represented as a 9-element list where each cell is:
/// - `null` → empty
/// - `'X'`  → player
/// - `'O'`  → AI (maximizer)
///
/// The algorithm assigns terminal-state scores:
/// - **+10** when AI ('O') wins
/// - **-10** when player ('X') wins
/// - **0** on draw
///
/// It recursively explores all possible moves. The AI maximizes its score;
/// the player minimizes it. This makes the AI unbeatable.
class Minimax {
  static const String _ai = 'O';
  static const String _player = 'X';

  // Sentinel values larger than any reachable score (max terminal score is ±10).
  static const int _minScore = -1000;
  static const int _maxScore = 1000;

  // All winning combinations: rows, columns, then diagonals.
  static const List<List<int>> _lines = [
    [0, 1, 2], [3, 4, 5], [6, 7, 8],
    [0, 3, 6], [1, 4, 7], [2, 5, 8],
    [0, 4, 8], [2, 4, 6],
  ];

  /// Returns the best move index (0–8) for the AI on the given [board].
  static int bestMove(List<String?> board) {
    int bestScore = _minScore;
    int bestMove = -1;

    for (int i = 0; i < 9; i++) {
      // Only consider empty cells.
      if (board[i] == null) {
        // Simulate the AI playing at cell i.
        final next = List<String?>.from(board)..[i] = _ai;

        // Evaluate this move — the next turn belongs to the player (minimizer).
        final score = _minimax(next, false);

        // Keep track of the move that yields the highest score.
        if (score > bestScore) {
          bestScore = score;
          bestMove = i;
        }
      }
    }

    return bestMove;
  }

  /// Returns `'X'`, `'O'`, or `null` (no winner yet or draw not checked).
  static String? checkWinner(List<String?> board) {
    for (final line in _lines) {
      final a = board[line[0]], b = board[line[1]], c = board[line[2]];

      // All three cells are the same non-null value → that player wins.
      if (a != null && a == b && b == c) return a;
    }
    return null;
  }

  /// Returns the winning cell indices for the current board, or `null` if no winner.
  static List<int>? getWinningLine(List<String?> board) {
    for (final line in _lines) {
      final a = board[line[0]], b = board[line[1]], c = board[line[2]];

      // All three cells match → return the indices to highlight them in the UI.
      if (a != null && a == b && b == c) return line;
    }
    return null;
  }

  /// Recursively scores a board position.
  ///
  /// [isMaximizing] is `true` when it is the AI's turn, `false` for the player's turn.
  static int _minimax(List<String?> board, bool isMaximizing) {
    // Base case: check if the game is already over on this branch.
    final terminal = _terminalScore(board);
    if (terminal != null) return terminal;

    if (isMaximizing) {
      // AI's turn: try every empty cell and pick the highest-scoring outcome.
      int best = _minScore;
      for (int i = 0; i < 9; i++) {
        if (board[i] == null) {
          // Simulate AI playing at cell i, then let the player respond.
          final next = List<String?>.from(board)..[i] = _ai;
          best = max(best, _minimax(next, false));
        }
      }
      return best;
    } else {
      // Player's turn: try every empty cell and pick the lowest-scoring outcome.
      // Minimax assumes the player also plays optimally (worst case for the AI).
      int best = _maxScore;
      for (int i = 0; i < 9; i++) {
        if (board[i] == null) {
          // Simulate player playing at cell i, then let the AI respond.
          final next = List<String?>.from(board)..[i] = _player;
          best = min(best, _minimax(next, true));
        }
      }
      return best;
    }
  }

  /// Returns the score for a terminal board state, or `null` if the game is still in progress.
  static int? _terminalScore(List<String?> board) {
    final winner = checkWinner(board);
    if (winner == _ai) return 10;      // AI wins → positive score.
    if (winner == _player) return -10; // Player wins → negative score.
    if (board.every((c) => c != null)) return 0; // No empty cells left → draw.
    return null; // Game is still in progress.
  }
}
