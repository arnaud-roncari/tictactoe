import 'package:flutter/material.dart';
import 'package:tic_tac_toe/core/design_system/app_design_system.dart';
import 'package:tic_tac_toe/features/game/domain/enums/game_status.dart';

class CellWidget extends StatelessWidget {
  final String? value;
  final bool isWinning;
  final GameStatus gameStatus;
  final VoidCallback? onTap;

  const CellWidget({
    super.key,
    required this.value,
    required this.isWinning,
    required this.gameStatus,
    this.onTap,
  });

  Color _backgroundColor() {
    if (!isWinning) return AppColors.surface;
    if (gameStatus == GameStatus.playerWin) return AppColors.playerWin;
    return AppColors.aiWin;
  }

  Color _textColor() {
    if (value == 'X') return AppColors.primary;
    return AppColors.secondary;
  }

  Widget _cellContent() {
    if (value == null) return const SizedBox.shrink();
    return Text(
      value!,
      style: AppTextStyles.headline.copyWith(color: _textColor()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.all(AppSpacing.xs),
        decoration: BoxDecoration(
          color: _backgroundColor(),
          borderRadius: BorderRadius.circular(AppRadius.md),
        ),
        child: Center(child: _cellContent()),
      ),
    );
  }
}
