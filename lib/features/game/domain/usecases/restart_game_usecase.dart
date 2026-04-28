import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../entities/game_state.dart';
import '../enums/player.dart';
import 'init_game_usecase.dart';
import 'set_starting_player_usecase.dart';

part 'restart_game_usecase.g.dart';

/// Alternates the starting player, persists the choice, then returns a fresh [GameState].
///
/// Delegates persistence to [SetStartingPlayerUseCase] and board construction to [InitGameUseCase].
class RestartGameUseCase {
  final SetStartingPlayerUseCase _setStartingPlayer;
  final InitGameUseCase _initGame;

  const RestartGameUseCase(this._setStartingPlayer, this._initGame);

  Future<GameState> call(GameState currentState) async {
    final next = currentState.startingPlayer == Player.x ? Player.o : Player.x;
    await _setStartingPlayer(next);
    return _initGame();
  }
}

@riverpod
RestartGameUseCase restartGameUseCase(RestartGameUseCaseRef ref) {
  return RestartGameUseCase(
    ref.read(setStartingPlayerUseCaseProvider),
    ref.read(initGameUseCaseProvider),
  );
}
