import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tic_tac_toe/core/design_system/app_design_system.dart';
import 'package:tic_tac_toe/features/game/domain/enums/game_status.dart';
import 'package:tic_tac_toe/features/game/presentation/notifiers/game_notifier.dart';
import 'package:tic_tac_toe/features/game/presentation/widgets/cell_widget.dart';

class BoardWidget extends ConsumerWidget {
  const BoardWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final gameState = ref.watch(gameNotifierProvider);
    final notifier = ref.read(gameNotifierProvider.notifier);

    return Padding(
      padding: AppPadding.page,
      child: AspectRatio(
        aspectRatio: 1,
        child: GridView.builder(
          key: const Key('board'),
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
          ),
          itemCount: 9,
          itemBuilder: (context, index) => CellWidget(
            key: Key('cell_$index'),
            value: gameState.board[index],
            isWinning: gameState.winningCells.contains(index),
            gameStatus: gameState.status,
            onTap: gameState.status == GameStatus.playing
                ? () => notifier.makeMove(index)
                : null,
          ),
        ),
      ),
    );
  }
}
