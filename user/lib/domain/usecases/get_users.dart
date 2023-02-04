import 'package:dartz/dartz.dart';
import 'package:core/commons/failures.dart';
import 'package:user/domain/entities/user.dart';
import 'package:user/domain/repositories/user_repository.dart';

class GetUsers {
  final UserRepository repository;

  GetUsers(this.repository);

  Future<Either<Failure, List<User>>> execute() {
    return repository.getUsers();
  }
}
