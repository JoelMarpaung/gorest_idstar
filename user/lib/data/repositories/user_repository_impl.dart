import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:user/data/datasources/user_remote_data_source.dart';
import 'package:user/data/models/user_model.dart';
import 'package:user/domain/entities/user.dart';
import 'package:user/domain/repositories/user_repository.dart';
import 'package:core/commons/exceptions.dart';
import 'package:core/commons/failures.dart';

class UserRepositoryImpl implements UserRepository {
  final UserDataSource dataSource;

  UserRepositoryImpl({
    required this.dataSource,
  });

  @override
  Future<Either<Failure, List<User>>> searchUsers(String query) async {
    try {
      final result = await dataSource.searchUsers(query);
      if (result.isEmpty) {
        return const Left(EmptyDataFailure('No Data Found.'));
      }
      return Right(result.map((model) => model.toEntity()).toList());
    } on RateLimitException {
      return const Left(RateLimitFailure('Rate Limit Exceeded.'));
    } on ServerException {
      return const Left(ServerFailure('Oops!!! Something went wrong'));
    } on SocketException {
      return const Left(ConnectionFailure('Failed to connect to the network'));
    }
  }

  @override
  Future<Either<Failure, List<User>>> getUsers() async {
    try {
      final result = await dataSource.getUsers();
      if (result.isEmpty) {
        return const Left(EmptyDataFailure('No Data Found.'));
      }
      return Right(result.map((model) => model.toEntity()).toList());
    } on RateLimitException {
      return const Left(RateLimitFailure('Rate Limit Exceeded.'));
    } on ServerException {
      return const Left(ServerFailure('Oops!!! Something went wrong'));
    } on SocketException {
      return const Left(ConnectionFailure('Failed to connect to the network'));
    }
  }

  @override
  Future<Either<Failure, bool>> addUser(UserModel user) async {
    try {
      final result = await dataSource.addUser(user);
      if (result != true) {
        return const Left(EmptyDataFailure('Failed to add data'));
      }
      return const Right(true);
    } on RateLimitException {
      return const Left(RateLimitFailure('Rate Limit Exceeded.'));
    } on ServerException {
      return const Left(ServerFailure('Oops!!! Something went wrong'));
    } on SocketException {
      return const Left(ConnectionFailure('Failed to connect to the network'));
    }
  }

  @override
  Future<Either<Failure, bool>> deleteUser(int id) async {
    try {
      final result = await dataSource.deleteUser(id);
      if (result != true) {
        return const Left(EmptyDataFailure('Failed to delete data'));
      }
      return const Right(true);
    } on RateLimitException {
      return const Left(RateLimitFailure('Rate Limit Exceeded.'));
    } on ServerException {
      return const Left(ServerFailure('Oops!!! Something went wrong'));
    } on SocketException {
      return const Left(ConnectionFailure('Failed to connect to the network'));
    }
  }

  @override
  Future<Either<Failure, bool>> editUser(UserModel user) async {
    try {
      final result = await dataSource.editUser(user);
      if (result != true) {
        return const Left(EmptyDataFailure('Failed to edit data'));
      }
      return const Right(true);
    } on RateLimitException {
      return const Left(RateLimitFailure('Rate Limit Exceeded.'));
    } on ServerException {
      return const Left(ServerFailure('Oops!!! Something went wrong'));
    } on SocketException {
      return const Left(ConnectionFailure('Failed to connect to the network'));
    }
  }
}
