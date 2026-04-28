/// Abstract contract for key-value local storage.
///
/// Reading is synchronous (data already loaded in memory after init).
/// Writing is asynchronous (flush to disk).
abstract class LocalStorageDatasource {
  String? getString(String key);
  Future<void> setString(String key, String value);
  Future<void> remove(String key);
}
