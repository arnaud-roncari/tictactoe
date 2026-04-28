import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/design_system/app_design_system.dart';
import '../../domain/enums/game_status.dart';
import '../notifiers/game_notifier.dart';
import '../widgets/board_widget.dart';
import '../widgets/result_banner_widget.dart';

class GamePage extends ConsumerWidget {
  const GamePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final gameState = ref.watch(gameNotifierProvider);

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          children: [
            if (gameState.status != GameStatus.playing)
              ResultBannerWidget(status: gameState.status),
            const Expanded(
              child: Center(
                child: BoardWidget(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
