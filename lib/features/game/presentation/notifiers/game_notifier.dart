import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:tic_tac_toe/features/game/domain/entities/game_state.dart';
import 'package:tic_tac_toe/features/game/domain/usecases/init_game_usecase.dart';
import 'package:tic_tac_toe/features/game/domain/usecases/make_move_usecase.dart';
import 'package:tic_tac_toe/features/game/domain/usecases/restart_game_usecase.dart';

part 'game_notifier.g.dart';

/// Orchestrates the TicTacToe game lifecycle.
///
/// Contains no business logic — delegates entirely to domain use cases obtained via [ref]:
/// - [initGameUseCaseProvider] to build the initial board state from the repository
/// - [makeMoveUseCaseProvider] to process each player move and AI response
/// - [restartGameUseCaseProvider] to alternate the starting player, persist it, and reset the board
@riverpod
class GameNotifier extends _$GameNotifier {
  @override
  GameState build() {
    return ref.watch(initGameUseCaseProvider)();
  }

  /// Places the player's mark at [index] and lets the AI respond.
  void makeMove(int index) {
    state = ref.read(makeMoveUseCaseProvider)(state, index);
  }

  /// Resets the board, alternates the starting player, and persists the change.
  Future<void> restart() async {
    state = await ref.read(restartGameUseCaseProvider)(state);
  }
}
