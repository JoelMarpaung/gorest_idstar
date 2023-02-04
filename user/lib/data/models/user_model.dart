// ignore_for_file: unused_import

import 'dart:convert';

import 'package:equatable/equatable.dart';

import '../../domain/entities/user.dart';

class UserModel extends Equatable {
  const UserModel({
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

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        id: json["id"],
        name: json["name"],
        email: json["email"],
        gender: json["gender"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "email": email,
        "gender": gender,
        "status": status,
      };

  User toEntity() {
    return User(
        id: id, name: name, email: email, gender: gender, status: status);
  }

  @override
  List<Object> get props => [id, name, email, gender, status];
}

List<UserModel> parseUsers(dynamic json) {
  if (json == null) {
    return [];
  }

  final List parsed = json as List;
  return parsed.map((json) => UserModel.fromJson(json)).toList();
}
