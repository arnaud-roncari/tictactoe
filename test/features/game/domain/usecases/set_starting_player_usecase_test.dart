import 'package:flutter_test/flutter_test.dart';
import 'package:tic_tac_toe/features/game/domain/enums/player.dart';
import 'package:tic_tac_toe/features/game/domain/usecases/set_starting_player_usecase.dart';
import '../../../../mocks/repositories/starting_player_repository_mock.dart';

void main() {
  group('SetStartingPlayerUseCase', () {
    test('persists Player.x in the repository', () async {
      final repo = StartingPlayerRepositoryMock(initial: Player.o);
      await SetStartingPlayerUseCase(repo)(Player.x);

      expect(repo.getStartingPlayer(), Player.x);
    });

    test('persists Player.o in the repository', () async {
      final repo = StartingPlayerRepositoryMock(initial: Player.x);
      await SetStartingPlayerUseCase(repo)(Player.o);

      expect(repo.getStartingPlayer(), Player.o);
    });
  });
}
