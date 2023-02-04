import 'package:dartz/dartz.dart';
import 'package:user/domain/entities/user.dart';
import 'package:core/commons/failures.dart';

import '../../data/models/user_model.dart';

abstract class UserRepository {
  Future<Either<Failure, List<User>>> getUsers();
  Future<Either<Failure, List<User>>> searchUsers(String name);
  Future<Either<Failure, bool>> addUser(UserModel user);
  Future<Either<Failure, bool>> editUser(UserModel user);
  Future<Either<Failure, bool>> deleteUser(int id);
}
