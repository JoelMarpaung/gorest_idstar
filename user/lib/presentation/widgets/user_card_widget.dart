import 'package:flutter/material.dart';

import '../../domain/entities/user.dart';

class UserCard extends StatelessWidget {
  final User user;

  const UserCard(this.user, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4),
      child: InkWell(
        onTap: () {},
        child: Card(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('ID: ${user.id}'),
              Text('NAMA: ${user.name}'),
              Text('EMAIL: ${user.email}'),
              Text('GENDER: ${user.gender}'),
              Text('NAMA: ${user.status}'),
            ],
          ),
        ),
      ),
    );
  }
}
