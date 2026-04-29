import 'package:tic_tac_toe/features/game/domain/enums/player.dart';

/// Persists and retrieves who should start the next game.
abstract class StartingPlayerRepository {
  /// Returns the stored starting player, defaulting to [Player.x] if none is set.
  Player getStartingPlayer();

  /// Stores [player] as the starting player for the next game.
  Future<void> setStartingPlayer(Player player);
}
