## 0.1.0

Initial release.

* `SharedPreferencesStorage`, a `ZenithStorage` over `SharedPreferences` with
  `load()` for the one-time asynchronous initialization.
* `clear()` removes only the keys that instance wrote, so it cannot wipe the host
  app's other preferences.
* Extracted from `flutter_zenith` 0.14.x, which briefly shipped it in a
  `persistence_shared_preferences.dart` entrypoint. The engine no longer depends on
  `shared_preferences`.
