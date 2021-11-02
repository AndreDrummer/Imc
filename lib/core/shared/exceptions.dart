class AppExceptions implements Exception {
  final dynamic message;

  AppExceptions([this.message]);

  @override
  String toString() {
    Object? message = this.message;
    if (message == null) return "Exception";
    return "Exception: $message";
  }
}
