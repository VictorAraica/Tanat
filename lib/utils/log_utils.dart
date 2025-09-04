// ignore_for_file: avoid_print
abstract class LogUtils {
  static void init(bool debugMode) {
    _debugMode = debugMode;
  }

  static bool _debugMode = true;

  static void logDebug(Object? value, [String? mark]) {
    if (_debugMode) {
      if (mark != null) {
        print(mark);
      }
      print(value);
      if (mark != null) {
        print(mark);
      }
    }
  }
}
