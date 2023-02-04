import 'package:equatable/equatable.dart';

abstract class GetUserEvent extends Equatable {
  const GetUserEvent();
}

class OnGetUser extends GetUserEvent {
  const OnGetUser();

  @override
  List<Object> get props => [];
}

class OnSearchUser extends GetUserEvent {
  final String query;
  const OnSearchUser(this.query);

  @override
  List<Object> get props => [];
}
