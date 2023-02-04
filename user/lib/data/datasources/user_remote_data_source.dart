import 'package:dio/dio.dart';
import 'package:core/constants/urls.dart';
import 'package:user/data/models/user_model.dart';
import 'package:core/commons/exceptions.dart';

abstract class UserDataSource {
  Future<List<UserModel>> searchUsers(String name);
  Future<List<UserModel>> getUsers();
}

class UserDataSourceImpl implements UserDataSource {
  final Dio client;

  UserDataSourceImpl({required this.client});

  @override
  Future<List<UserModel>> searchUsers(String name) async {
    try {
      final response = await client.get('$goRestUrl$userUrl', queryParameters: {"name": name});
      if (response.statusCode == 200) {
        return parseUsers(response.data);
      } else if (response.statusCode == 429) {
        throw RateLimitException();
      } else {
        throw ServerException();
      }
    } on DioError catch (e) {
      if (e.type == DioErrorType.response) {
        if (e.response?.statusCode == 429) {
          throw RateLimitException();
        } else {
          throw ServerException();
        }
      } else {
        rethrow;
      }
    }
  }

  @override
  Future<List<UserModel>> getUsers() async {
    try {
      Response response = await client.get('$goRestUrl$userUrl');
      if (response.statusCode == 200) {
        return parseUsers(response.data);
      } else if (response.statusCode == 429) {
        throw RateLimitException();
      } else {
        throw ServerException();
      }
    } on DioError catch (e) {
      if (e.type == DioErrorType.response) {
        if (e.response?.statusCode == 429) {
          throw RateLimitException();
        } else {
          throw ServerException();
        }
      } else {
        rethrow;
      }
    }
  }
}
