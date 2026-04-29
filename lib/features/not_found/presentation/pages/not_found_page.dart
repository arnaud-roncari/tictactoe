import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tic_tac_toe/core/constants/app_routes.dart';
import 'package:tic_tac_toe/core/design_system/app_design_system.dart';

class NotFoundPage extends StatelessWidget {
  const NotFoundPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('404', style: AppTextStyles.headline),
            const SizedBox(height: AppSpacing.md),
            const Text('Page not found', style: AppTextStyles.body),
            const SizedBox(height: AppSpacing.xl),
            ElevatedButton(
              onPressed: () => context.go(AppRoutes.home),
              child: const Text('Go Home'),
            ),
          ],
        ),
      ),
    );
  }
}
