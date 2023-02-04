import 'package:equatable/equatable.dart';

import '../../../domain/entities/user.dart';

abstract class GetUserState extends Equatable {
  const GetUserState();

  @override
  List<Object> get props => [];
}

class GetUserEmpty extends GetUserState {}

class GetUserLoading extends GetUserState {}

class GetUserError extends GetUserState {
  final String message;

  const GetUserError(this.message);

  @override
  List<Object> get props => [message];
}

class GetUserHasData extends GetUserState {
  final List<User> result;

  const GetUserHasData(this.result);

  @override
  List<Object> get props => [result];
}
