///
sealed class Failure implements Exception {
  ///
  Failure([this.message]);

  /// errr message
  String? message;

  ///
  @override
  String toString() {
    final message = this.message;
    if (message == null) return 'fatal error';
    return 'Exception: $message';
  }
}

///
class NotFoundFailure extends Failure {
  ///
  NotFoundFailure([
    String super.message = 'Resource not found.',
  ]);

  ///
  @override
  String toString() {
    return message ?? '';
  }
}

///
class IncompleteFormFailure extends Failure {
  ///
  IncompleteFormFailure([
    String super.message = 'Form is incomplete',
  ]);

  ///
  @override
  String toString() {
    return message ?? '';
  }
}

///
class DBFailure extends Failure {
  ///
  DBFailure([
    String super.message = 'Cannot complete this operation',
  ]);

  ///
  @override
  String toString() {
    return message ?? '';
  }
}
