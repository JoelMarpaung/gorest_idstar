// ignore_for_file: unused_import

import 'package:dartz/dartz.dart';
import 'package:core/commons/failures.dart';
import 'package:user/data/models/user_model.dart';
import 'package:user/domain/entities/user.dart';
import 'package:user/domain/repositories/user_repository.dart';

class EditUser {
  final UserRepository repository;

  EditUser(this.repository);

  Future<Either<Failure, bool>> execute(UserModel user) {
    return repository.editUser(user);
  }
}
