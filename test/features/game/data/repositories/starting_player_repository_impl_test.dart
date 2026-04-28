import 'package:flutter_test/flutter_test.dart';
import 'package:tic_tac_toe/features/game/data/repositories/starting_player_repository_impl.dart';
import 'package:tic_tac_toe/features/game/domain/enums/player.dart';
import '../../../../mocks/datasources/local_storage_datasource_mock.dart';

void main() {
  StartingPlayerRepositoryImpl makeRepo() =>
      StartingPlayerRepositoryImpl(LocalStorageDatasourceMock());

  group('StartingPlayerRepositoryImpl — getStartingPlayer', () {
    test('returns Player.x by default when nothing is stored', () {
      expect(makeRepo().getStartingPlayer(), Player.x);
    });

    test('returns Player.o after setStartingPlayer(Player.o)', () async {
      final repo = makeRepo();
      await repo.setStartingPlayer(Player.o);

      expect(repo.getStartingPlayer(), Player.o);
    });

    test('returns Player.x after setStartingPlayer(Player.x)', () async {
      final repo = makeRepo();
      await repo.setStartingPlayer(Player.o);
      await repo.setStartingPlayer(Player.x);

      expect(repo.getStartingPlayer(), Player.x);
    });
  });
}
