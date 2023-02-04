import 'package:dartz/dartz.dart';
import 'package:core/commons/failures.dart';
import 'package:user/data/models/user_model.dart';
import 'package:user/domain/entities/user.dart';
import 'package:user/domain/repositories/user_repository.dart';

class DeleteUser {
  final UserRepository repository;

  DeleteUser(this.repository);

  Future<Either<Failure, bool>> execute(int id) {
    return repository.deleteUser(id);
  }
}
