// ignore_for_file: unused_import

import 'package:equatable/equatable.dart';

import '../../../domain/entities/user.dart';

abstract class CrudUserState extends Equatable {
  const CrudUserState();

  @override
  List<Object> get props => [];
}

class CrudUserEmpty extends CrudUserState {}

class CrudUserLoading extends CrudUserState {}

class CrudUserError extends CrudUserState {
  final String message;

  const CrudUserError(this.message);

  @override
  List<Object> get props => [message];
}

class CrudUserHasData extends CrudUserState {
  final bool result;

  const CrudUserHasData(this.result);

  @override
  List<Object> get props => [result];
}
