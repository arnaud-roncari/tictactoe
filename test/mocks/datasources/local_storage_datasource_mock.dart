import 'package:tic_tac_toe/features/game/domain/datasources/local_storage_datasource.dart';

/// In-memory mock of [LocalStorageDatasource] for use in tests.
class LocalStorageDatasourceMock implements LocalStorageDatasource {
  final Map<String, String> _store = {};

  @override
  String? getString(String key) => _store[key];

  @override
  Future<void> setString(String key, String value) async => _store[key] = value;

  @override
  Future<void> remove(String key) async => _store.remove(key);
}
