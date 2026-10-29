/// A `ZenithStorage` backed by `SharedPreferences`.
///
/// ```dart
/// import 'package:flutter_zenith/flutter_zenith.dart';
/// import 'package:flutter_zenith_shared_preferences/flutter_zenith_shared_preferences.dart';
///
/// final backend = await SharedPreferencesStorage.load();
/// final theme = PersistedNode.string(
///   key: 'theme',
///   defaultValue: 'system',
///   storage: ScopedStorage(backend, scope: userId),
/// );
/// ```
library;

export 'src/shared_preferences_storage.dart';
