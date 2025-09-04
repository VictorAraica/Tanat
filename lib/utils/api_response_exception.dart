class ApiResponseException implements Exception {
  const ApiResponseException([
    this.message,
    this.responseCode = 400,
    this.data,
    this.code,
  ]);

  final dynamic message;
  final int? responseCode;

  final Map<String, dynamic>? data;

  final String? code;

  @override
  String toString() {
    final Object? message = this.message;
    if (message == null) return 'ApiResponseException';
    return '$message';
  }
}
