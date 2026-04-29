import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tic_tac_toe/core/design_system/app_design_system.dart';
import 'package:tic_tac_toe/core/l10n/app_localizations.dart';
import 'package:tic_tac_toe/features/game/domain/enums/game_status.dart';
import 'package:tic_tac_toe/features/game/presentation/notifiers/game_notifier.dart';

class ResultBannerWidget extends ConsumerWidget {
  final GameStatus status;

  const ResultBannerWidget({super.key, required this.status});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;

    final String message = switch (status) {
      GameStatus.playerWin => l10n.playerWins,
      GameStatus.aiWin => l10n.aiWins,
      GameStatus.draw => l10n.draw,
      GameStatus.playing => '',
    };

    if (status == GameStatus.playing) return const SizedBox.shrink();

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(height: AppSpacing.lg),
        Text(message, style: AppTextStyles.headline, textAlign: TextAlign.center),
        SizedBox(height: AppSpacing.md),
        ElevatedButton(
          key: const Key('restart_button'),
          onPressed: () => ref.read(gameNotifierProvider.notifier).restart(),
          child: Text(l10n.restart),
        ),
        SizedBox(height: AppSpacing.lg),
      ],
    );
  }
}
