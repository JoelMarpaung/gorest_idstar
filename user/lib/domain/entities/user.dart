import 'package:equatable/equatable.dart';

class User extends Equatable {
  const User({
    required this.id,
    required this.name,
    required this.email,
    required this.gender,
    required this.status,
  });

  final int id;
  final String name;
  final String email;
  final String gender;
  final String status;

  @override
  List<Object> get props => [id, name, email, gender, status];
}