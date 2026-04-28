import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/design_system/app_design_system.dart';
import '../../../../core/l10n/app_localizations.dart';
import '../../../../core/constants/app_routes.dart';
import '../widgets/start_button_widget.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: AppPadding.page,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(l10n.homeTitle, style: AppTextStyles.display),
                const SizedBox(height: AppSpacing.md),
                Text(l10n.homeSubtitle, style: AppTextStyles.body, textAlign: TextAlign.center),
                const SizedBox(height: AppSpacing.xxl),
                StartButtonWidget(onPressed: () => context.go(AppRoutes.game)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
