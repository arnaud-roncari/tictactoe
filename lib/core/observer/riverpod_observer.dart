import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';

/// Logs Riverpod provider state changes in debug mode.
class RiverpodObserver extends ProviderObserver {
  final Logger _logger = Logger(printer: PrettyPrinter(methodCount: 2, errorMethodCount: 8));

  @override
  void didUpdateProvider(
    ProviderBase<dynamic> provider,
    Object? previousValue,
    Object? newValue,
    ProviderContainer container,
  ) {
    if (kDebugMode) {
      _logger.d(
        '[Riverpod] ${provider.name ?? provider.runtimeType}\n'
        '  prev: $previousValue\n'
        '  next: $newValue',
      );
    }
  }

  @override
  void providerDidFail(
    ProviderBase<dynamic> provider,
    Object error,
    StackTrace stackTrace,
    ProviderContainer container,
  ) {
    if (kDebugMode) {
      _logger.e('[Riverpod] ${provider.name ?? provider.runtimeType} failed', error: error, stackTrace: stackTrace);
    }
  }
}
