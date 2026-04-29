import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:tic_tac_toe/features/game/data/repositories/starting_player_repository_impl.dart';
import 'package:tic_tac_toe/features/game/domain/enums/player.dart';
import 'package:tic_tac_toe/features/game/domain/repositories/starting_player_repository.dart';

part 'set_starting_player_usecase.g.dart';

/// Persists [player] as the next starting player via [StartingPlayerRepository].
class SetStartingPlayerUseCase {
  final StartingPlayerRepository _repo;

  const SetStartingPlayerUseCase(this._repo);

  Future<void> call(Player player) => _repo.setStartingPlayer(player);
}

@riverpod
SetStartingPlayerUseCase setStartingPlayerUseCase(SetStartingPlayerUseCaseRef ref) {
  return SetStartingPlayerUseCase(ref.read(startingPlayerRepositoryProvider));
}
