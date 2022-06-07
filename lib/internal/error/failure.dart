abstract class Failure {}

class ServerFailure extends Failure {
  @override
  String toString() {
    return "Server Failure";
  }
}

class NotFoundFailure extends Failure {
  @override
  String toString() {
    return "Not Found Failure";
  }
}

class MissingParametersFailure extends Failure {
  @override
  String toString() {
    return "Missing Parameters Failure";
  }
}

class UnknownFailure extends Failure {
  @override
  String toString() {
    return "Unknown Failure";
  }
}

class HiveFailure extends Failure {}
