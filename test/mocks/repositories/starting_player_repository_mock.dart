import 'package:tic_tac_toe/features/game/domain/enums/player.dart';
import 'package:tic_tac_toe/features/game/domain/repositories/starting_player_repository.dart';

/// In-memory mock of [StartingPlayerRepository] for use in tests.
class StartingPlayerRepositoryMock implements StartingPlayerRepository {
  Player _current;

  StartingPlayerRepositoryMock({Player initial = Player.x}) : _current = initial;

  @override
  Player getStartingPlayer() => _current;

  @override
  Future<void> setStartingPlayer(Player player) async => _current = player;
}
