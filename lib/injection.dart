import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:user/data/datasources/user_remote_data_source.dart';
import 'package:user/data/repositories/user_repository_impl.dart';
import 'package:user/domain/repositories/user_repository.dart';
import 'package:user/domain/usecases/Search_users.dart';
import 'package:user/domain/usecases/get_users.dart';
import 'package:user/presentation/bloc/get_user_bloc/get_user_bloc.dart';

final locator = GetIt.instance;

Future<void> init() async {
  //blocs
  locator.registerFactory(
        () => GetUserBloc(locator(),locator()),
  );

  //usecases
  locator.registerLazySingleton(() => GetUsers(locator()));
  locator.registerLazySingleton(() => SearchUsers(locator()));

  //repositories
  locator.registerLazySingleton<UserRepository>(
          () => UserRepositoryImpl(dataSource: locator()));

  //datasources
  locator.registerLazySingleton<UserDataSource>(
          () => UserDataSourceImpl(client: locator()));

  //client dio
  locator.registerLazySingleton(() => Dio());
}