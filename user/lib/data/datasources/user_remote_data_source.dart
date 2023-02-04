import 'package:dio/dio.dart';
import 'package:core/constants/urls.dart';
import 'package:user/data/models/user_model.dart';
import 'package:core/commons/exceptions.dart';

abstract class UserDataSource {
  Future<List<UserModel>> searchUsers(String name);
  Future<List<UserModel>> getUsers();
  Future<bool> addUser(UserModel user);
  Future<bool> editUser(UserModel user);
  Future<bool> deleteUser(int id);
}

class UserDataSourceImpl implements UserDataSource {
  final Dio client;

  UserDataSourceImpl({required this.client});

  @override
  Future<List<UserModel>> searchUsers(String name) async {
    try {
      final response = await client
          .get('$goRestUrl$userUrl', queryParameters: {"name": name});
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

  @override
  Future<bool> addUser(UserModel user) async {
    try {
      Map<String, String> headers = {
        "Accept": "application/json",
        "Content-Type": "application/json",
        "Authorization": "Bearer $accessToken"
      };
      client.options.headers.addAll(headers);
      var formData = FormData.fromMap({
        'name': user.name,
        'email': user.email,
        'gender': user.gender,
        'status': user.status
      });
      Response response =
          await client.post('$goRestUrl$userUrl', data: formData);
      if (response.statusCode == 201) {
        return true;
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
  Future<bool> deleteUser(int id) async {
    try {
      Map<String, String> headers = {
        "Accept": "application/json",
        "Content-Type": "application/json",
        "Authorization": "Bearer $accessToken"
      };
      client.options.headers.addAll(headers);
      Response response = await client.delete('$goRestUrl$userUrl/$id');
      if (response.statusCode == 201) {
        return true;
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
  Future<bool> editUser(UserModel user) async {
    try {
      Map<String, String> headers = {
        "Accept": "application/json",
        "Content-Type": "application/json",
        "Authorization": "Bearer $accessToken"
      };
      client.options.headers.addAll(headers);
      var formData = FormData.fromMap({
        'name': user.name,
        'email': user.email,
        'gender': user.gender,
        'status': user.status
      });
      Response response =
          await client.put('$goRestUrl$userUrl/${user.id}', data: formData);
      if (response.statusCode == 201) {
        return true;
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
