import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  final String message;

  const Failure(this.message);

  @override
  List<Object> get props => [message];
}

class EmptyDataFailure extends Failure {
  const EmptyDataFailure(String message) : super(message);
}

class ServerFailure extends Failure {
  const ServerFailure(String message) : super(message);
}

class ConnectionFailure extends Failure {
  const ConnectionFailure(String message) : super(message);
}

class RateLimitFailure extends Failure {
  const RateLimitFailure(String message) : super(message);
}
