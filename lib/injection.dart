import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:user/data/datasources/user_remote_data_source.dart';
import 'package:user/data/repositories/user_repository_impl.dart';
import 'package:user/domain/repositories/user_repository.dart';
import 'package:user/domain/usecases/search_users.dart';
import 'package:user/domain/usecases/get_users.dart';
import 'package:user/domain/usecases/add_user.dart';
import 'package:user/domain/usecases/edit_user.dart';
import 'package:user/domain/usecases/delete_user.dart';
import 'package:user/presentation/bloc/get_user_bloc/get_user_bloc.dart';
import 'package:user/presentation/bloc/crud_user_bloc/crud_user_bloc.dart';

final locator = GetIt.instance;

Future<void> init() async {
  //blocs
  locator.registerFactory(
    () => GetUserBloc(locator(), locator()),
  );

  locator.registerFactory(
    () => CrudUserBloc(locator(), locator(), locator()),
  );

  //usecases
  locator.registerLazySingleton(() => GetUsers(locator()));
  locator.registerLazySingleton(() => SearchUsers(locator()));
  locator.registerLazySingleton(() => AddUser(locator()));
  locator.registerLazySingleton(() => EditUser(locator()));
  locator.registerLazySingleton(() => DeleteUser(locator()));

  //repositories
  locator.registerLazySingleton<UserRepository>(
      () => UserRepositoryImpl(dataSource: locator()));

  //datasources
  locator.registerLazySingleton<UserDataSource>(
      () => UserDataSourceImpl(client: locator()));

  //client dio
  locator.registerLazySingleton(() => Dio());
}
