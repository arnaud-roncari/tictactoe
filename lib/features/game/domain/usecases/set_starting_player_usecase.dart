import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../enums/player.dart';
import '../repositories/starting_player_repository.dart';
import '../../data/repositories/starting_player_repository_impl.dart';

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
