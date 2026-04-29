import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:tic_tac_toe/features/game/domain/enums/game_status.dart';
import 'package:tic_tac_toe/features/game/domain/enums/player.dart';

part 'game_state.freezed.dart';

@freezed
class GameState with _$GameState {
  const factory GameState({
    required List<String?> board,
    required Player currentPlayer,
    required Player startingPlayer,
    required GameStatus status,
    @Default(<int>[]) List<int> winningCells,
  }) = _GameState;
}
