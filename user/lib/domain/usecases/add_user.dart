import 'package:dartz/dartz.dart';
import 'package:core/commons/failures.dart';
import 'package:user/data/models/user_model.dart';
import 'package:user/domain/repositories/user_repository.dart';

class AddUser {
  final UserRepository repository;

  AddUser(this.repository);

  Future<Either<Failure, bool>> execute(UserModel user) {
    return repository.addUser(user);
  }
}
