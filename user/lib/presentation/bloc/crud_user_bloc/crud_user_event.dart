import 'package:equatable/equatable.dart';

import '../../../data/models/user_model.dart';

abstract class CrudUserEvent extends Equatable {
  const CrudUserEvent();
}

class OnAddUser extends CrudUserEvent {
  final UserModel user;
  const OnAddUser(this.user);

  @override
  List<Object> get props => [];
}

class OnEditUser extends CrudUserEvent {
  final UserModel user;
  const OnEditUser(this.user);

  @override
  List<Object> get props => [];
}

class OnDeleteUser extends CrudUserEvent {
  final int id;
  const OnDeleteUser(this.id);

  @override
  List<Object> get props => [];
}
