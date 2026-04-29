import 'package:flutter/material.dart';
import 'package:tic_tac_toe/core/l10n/app_localizations.dart';

class StartButtonWidget extends StatelessWidget {
  final VoidCallback onPressed;

  const StartButtonWidget({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      key: const Key('start_button'),
      onPressed: onPressed,
      child: Text(AppLocalizations.of(context)!.startGame),
    );
  }
}
