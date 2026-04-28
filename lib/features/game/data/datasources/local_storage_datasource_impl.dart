import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../domain/datasources/local_storage_datasource.dart';

part 'local_storage_datasource_impl.g.dart';

/// [SharedPreferences]-backed implementation of [LocalStorageDatasource].
///
/// Reads are synchronous because [SharedPreferences] loads all values into
/// memory on initialisation. Writes flush to disk asynchronously.
class LocalStorageDatasourceImpl implements LocalStorageDatasource {
  final SharedPreferences _prefs;

  const LocalStorageDatasourceImpl(this._prefs);

  @override
  String? getString(String key) => _prefs.getString(key);

  @override
  Future<void> setString(String key, String value) => _prefs.setString(key, value);

  @override
  Future<void> remove(String key) => _prefs.remove(key);
}

/// Must be overridden in [ProviderScope] with a [LocalStorageDatasourceImpl]
/// initialised from [SharedPreferences].
@Riverpod(keepAlive: true)
LocalStorageDatasource localStorageDatasource(LocalStorageDatasourceRef ref) {
  throw UnimplementedError(
    'localStorageDatasourceProvider must be overridden in ProviderScope.',
  );
}
