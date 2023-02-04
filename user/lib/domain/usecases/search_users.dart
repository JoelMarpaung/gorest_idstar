import 'package:dartz/dartz.dart';
import 'package:core/commons/failures.dart';
import 'package:user/domain/entities/user.dart';
import 'package:user/domain/repositories/user_repository.dart';

class SearchUsers {
  final UserRepository repository;

  SearchUsers(this.repository);

  Future<Either<Failure, List<User>>> execute(String name) {
    return repository.searchUsers(name);
  }
}
