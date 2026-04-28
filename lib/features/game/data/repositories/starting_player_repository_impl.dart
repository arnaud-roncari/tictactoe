import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../../core/constants/storage_keys.dart';
import '../../domain/datasources/local_storage_datasource.dart';
import '../../domain/enums/player.dart';
import '../../domain/repositories/starting_player_repository.dart';
import '../datasources/local_storage_datasource_impl.dart';

part 'starting_player_repository_impl.g.dart';

/// Reads and writes the starting player using [LocalStorageDatasource].
///
/// The player enum is stored as its [name] string (e.g. `'x'`, `'o'`).
/// If no value is stored, defaults to [Player.x].
class StartingPlayerRepositoryImpl implements StartingPlayerRepository {
  final LocalStorageDatasource _datasource;

  const StartingPlayerRepositoryImpl(this._datasource);

  @override
  Player getStartingPlayer() {
    final stored = _datasource.getString(StorageKeys.startingPlayer);
    // Return o only if explicitly stored — default is always x.
    if (stored == Player.o.name) return Player.o;
    return Player.x;
  }

  @override
  Future<void> setStartingPlayer(Player player) =>
      _datasource.setString(StorageKeys.startingPlayer, player.name);
}

@Riverpod(keepAlive: true)
StartingPlayerRepository startingPlayerRepository(StartingPlayerRepositoryRef ref) {
  return StartingPlayerRepositoryImpl(ref.read(localStorageDatasourceProvider));
}
