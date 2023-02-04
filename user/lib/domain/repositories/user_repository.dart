import 'package:dartz/dartz.dart';
import 'package:user/domain/entities/user.dart';
import 'package:core/commons/failures.dart';

abstract class UserRepository {
  Future<Either<Failure, List<User>>> getUsers();
  Future<Either<Failure, List<User>>> searchUsers(String name);
}
