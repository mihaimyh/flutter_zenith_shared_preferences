# flutter_zenith_shared_preferences

A `ZenithStorage` over `SharedPreferences` for
[`flutter_zenith`](https://pub.dev/packages/flutter_zenith).

`PersistedNode` reads its backend synchronously, so a node can hydrate before the
first frame instead of after an `await`. `SharedPreferences` is asynchronous once per
process; this adapter does that one load and then serves synchronous reads.

Kept out of the engine package on purpose: an app that never persists anything should
not install a platform plugin.

## Usage

```dart
import 'package:flutter_zenith/flutter_zenith.dart';
import 'package:flutter_zenith_shared_preferences/flutter_zenith_shared_preferences.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // One load per process.
  final backend = await SharedPreferencesStorage.load();

  // One namespace per account, so two users on one device never see each other.
  final storage = ScopedStorage(backend, scope: userId);

  final tier = PersistedNode.string(
    key: 'tier',
    defaultValue: 'explorer',
    storage: storage,
  );

  tier.value = 'fluent';
  await tier.flush();
}
```

## Behaviour worth knowing

- `read` is synchronous, so await `SharedPreferencesStorage.load()` before creating
  nodes.
- `clear()` deletes only the keys this instance wrote. `SharedPreferences.clear()`
  would also remove the host app's locale, settings cache and everything else it
  keeps, so the adapter never calls it.
- Writes are asynchronous and ordered per key by `PersistedNode`; `flush()` awaits a
  node's latest accepted write.
- Wrap it in `ScopedStorage` (from `flutter_zenith`) for per-account isolation. The
  scope and key are URI-encoded, so a crafted account id cannot escape its namespace.

## License

MIT. See [LICENSE](LICENSE).
