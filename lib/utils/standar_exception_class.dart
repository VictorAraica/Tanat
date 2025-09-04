class StandardException implements Exception {
  const StandardException([this.message]);
  final dynamic message;

  @override
  String toString() {
    final Object? message = this.message;
    if (message == null) return 'StandardException';
    return '$message';
  }
}
