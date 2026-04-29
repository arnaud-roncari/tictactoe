import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:tic_tac_toe/features/game/domain/algorithms/minimax.dart';
import 'package:tic_tac_toe/features/game/domain/entities/game_state.dart';
import 'package:tic_tac_toe/features/game/domain/enums/game_status.dart';
import 'package:tic_tac_toe/features/game/domain/enums/player.dart';

part 'make_move_usecase.g.dart';

/// Applies the player's move at [index], then computes and applies the AI move.
///
/// Returns the updated [GameState]. If the move is invalid (cell occupied or
/// game already over), the original state is returned unchanged.
class MakeMoveUseCase {
  const MakeMoveUseCase();

  GameState call(GameState state, int index) {
    // Ignore the tap if the game is already over or the cell is taken.
    if (state.status != GameStatus.playing) return state;
    if (state.board[index] != null) return state;

    // --- Player move ---
    final boardAfterPlayer = List<String?>.from(state.board)..[index] = 'X';

    // Check if the player's move wins the game.
    final playerWinLine = Minimax.getWinningLine(boardAfterPlayer);
    if (playerWinLine != null) {
      return state.copyWith(
        board: boardAfterPlayer,
        currentPlayer: Player.o,
        status: GameStatus.playerWin,
        winningCells: playerWinLine,
      );
    }

    // Check if the board is full after the player's move (draw before AI plays).
    if (boardAfterPlayer.every((c) => c != null)) {
      return state.copyWith(
        board: boardAfterPlayer,
        currentPlayer: Player.o,
        status: GameStatus.draw,
        winningCells: [],
      );
    }

    // --- AI move ---
    // Minimax computes the optimal cell index for the AI.
    final aiIndex = Minimax.bestMove(boardAfterPlayer);
    final boardAfterAi = List<String?>.from(boardAfterPlayer)..[aiIndex] = 'O';

    // Check if the AI's move wins the game.
    final aiWinLine = Minimax.getWinningLine(boardAfterAi);
    if (aiWinLine != null) {
      return state.copyWith(
        board: boardAfterAi,
        currentPlayer: Player.x,
        status: GameStatus.aiWin,
        winningCells: aiWinLine,
      );
    }

    // Check if the board is full after the AI's move (draw).
    if (boardAfterAi.every((c) => c != null)) {
      return state.copyWith(
        board: boardAfterAi,
        currentPlayer: Player.x,
        status: GameStatus.draw,
        winningCells: [],
      );
    }

    // Game continues — return the updated board with the player's turn.
    return state.copyWith(
      board: boardAfterAi,
      currentPlayer: Player.x,
      status: GameStatus.playing,
      winningCells: [],
    );
  }
}

@riverpod
MakeMoveUseCase makeMoveUseCase(MakeMoveUseCaseRef ref) {
  return const MakeMoveUseCase();
}
