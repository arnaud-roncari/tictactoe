import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:tic_tac_toe/features/game/data/repositories/starting_player_repository_impl.dart';
import 'package:tic_tac_toe/features/game/domain/algorithms/minimax.dart';
import 'package:tic_tac_toe/features/game/domain/entities/game_state.dart';
import 'package:tic_tac_toe/features/game/domain/enums/game_status.dart';
import 'package:tic_tac_toe/features/game/domain/enums/player.dart';
import 'package:tic_tac_toe/features/game/domain/repositories/starting_player_repository.dart';

part 'init_game_usecase.g.dart';

/// Builds the initial [GameState] by reading the starting player from [StartingPlayerRepository].
///
/// If [Player.o] starts, Minimax computes its optimal opening move and applies it
/// immediately so the player always starts on a non-empty board.
class InitGameUseCase {
  final StartingPlayerRepository _repo;

  const InitGameUseCase(this._repo);

  GameState call() {
    final startingPlayer = _repo.getStartingPlayer();
    final emptyBoard = List<String?>.filled(9, null);

    if (startingPlayer == Player.o) {
      // AI goes first: pick its optimal opening move.
      final aiIndex = Minimax.bestMove(emptyBoard);
      final board = List<String?>.from(emptyBoard)..[aiIndex] = 'O';
      return GameState(
        board: board,
        currentPlayer: Player.x,
        startingPlayer: Player.o,
        status: GameStatus.playing,
      );
    }

    return GameState(
      board: emptyBoard,
      currentPlayer: Player.x,
      startingPlayer: Player.x,
      status: GameStatus.playing,
    );
  }
}

@riverpod
InitGameUseCase initGameUseCase(InitGameUseCaseRef ref) {
  return InitGameUseCase(ref.read(startingPlayerRepositoryProvider));
}
