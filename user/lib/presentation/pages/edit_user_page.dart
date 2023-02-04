import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:user/presentation/bloc/crud_user_bloc/crud_user_bloc.dart';
import 'package:user/presentation/bloc/crud_user_bloc/crud_user_event.dart';
import '../../data/models/user_model.dart';
import '../../domain/entities/user.dart';
import '../bloc/crud_user_bloc/crud_user_state.dart';

class EditUserPage extends StatefulWidget {
  final User user;
  const EditUserPage({Key? key, required this.user}) : super(key: key);

  @override
  State<EditUserPage> createState() => _EditUserPageState();
}

class _EditUserPageState extends State<EditUserPage> {
  String _selectedStatus = '';
  String _selectedGender = '';
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _genderController = TextEditingController();
  final _statusController = TextEditingController();
  bool _validateName = false;
  bool _validateEmail = false;
  bool _validateGender = false;
  bool _validateStatus = false;
  bool _validEmail = false;

  @override
  void initState() {
    _selectedStatus = widget.user.status;
    _selectedGender = widget.user.gender;
    _nameController.text = widget.user.name;
    _emailController.text = widget.user.email;
    _genderController.text = _selectedGender;
    _statusController.text = _selectedStatus;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Edit User')),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: (Column(
            children: [
              TextField(
                  controller: _nameController,
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    hintText: 'Enter Name',
                    labelText: 'Name',
                    errorText:
                        _validateName ? 'Name Value Can\'t Be Empty' : null,
                  )),
              const SizedBox(
                height: 20.0,
              ),
              TextField(
                  keyboardType: TextInputType.emailAddress,
                  controller: _emailController,
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    hintText: 'Enter Email',
                    labelText: 'Email',
                    errorText:
                        _validateEmail ? 'Email Value Can\'t Be Empty' : null,
                  )),
              Text(
                _validEmail ? 'Email is not valid' : '',
                style: const TextStyle(color: Colors.red),
              ),
              const SizedBox(
                height: 20.0,
              ),
              Row(
                children: [
                  const Text('Select Gender :'),
                  const SizedBox(
                    width: 10,
                  ),
                  DropdownButton<String>(
                    value: _selectedGender,
                    hint: const Text('Select Gender'),
                    onChanged: (String? newValue) {
                      setState(() {
                        _selectedGender = newValue!;
                        _genderController.text = _selectedGender;
                      });
                    },
                    items: <String>['', 'male', 'female']
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                ],
              ),
              Text(
                _validateGender ? 'Gender Value Can\'t Be Empty' : '',
                style: const TextStyle(color: Colors.red),
              ),
              const SizedBox(
                height: 20.0,
              ),
              Row(
                children: [
                  const Text('Select Status :'),
                  const SizedBox(
                    width: 10,
                  ),
                  DropdownButton<String>(
                    value: _selectedStatus,
                    hint: const Text('Select Status'),
                    onChanged: (String? newValue) {
                      setState(() {
                        _selectedStatus = newValue!;
                        _statusController.text = _selectedStatus;
                      });
                    },
                    items: <String>['', 'active', 'inactive']
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                ],
              ),
              Text(
                _validateStatus ? 'Status Value Can\'t Be Empty' : '',
                style: const TextStyle(color: Colors.red),
              ),
              const SizedBox(
                height: 20.0,
              ),
              BlocBuilder<CrudUserBloc, CrudUserState>(
                  builder: (context, state) {
                return ElevatedButton(
                  onPressed: () async {
                    setState(() {
                      _validateEmail = false;
                      _validateGender = false;
                      _validateName = false;
                      _validateStatus = false;
                      _validEmail = false;
                    });
                    if (_nameController.text.isEmpty) {
                      setState(() {
                        _validateName = true;
                      });
                    }
                    if (_emailController.text.isEmpty) {
                      setState(() {
                        _validateEmail = true;
                      });
                    }
                    if (_genderController.text.isEmpty) {
                      setState(() {
                        _validateGender = true;
                      });
                    }
                    if (_statusController.text.isEmpty) {
                      setState(() {
                        _validateStatus = true;
                      });
                    }
                    if (!_emailController.text.isValidEmail()) {
                      setState(() {
                        _validEmail = true;
                      });
                    }
                    if (_nameController.text.isEmpty ||
                        _emailController.text.isEmpty ||
                        _emailController.text.isEmpty ||
                        _statusController.text.isEmpty ||
                        _validEmail == true) {
                      return;
                    }
                    var user = UserModel(
                        id: 0,
                        name: _nameController.text,
                        email: _emailController.text,
                        gender: _genderController.text,
                        status: _statusController.text);
                    context.read<CrudUserBloc>().add(OnEditUser(user));

                    String message = '';
                    if (state is CrudUserLoading) {
                      message = 'Loading...';
                    } else if (state is CrudUserError) {
                      message = state.message;
                    } else if (state is CrudUserHasData) {
                      message = 'Data Updated Success';
                    }
                    await Future.delayed(const Duration(seconds: 2));
                    if (!mounted) return;
                    ScaffoldMessenger.of(context)
                        .showSnackBar(SnackBar(content: Text(message)));
                    await Future.delayed(const Duration(seconds: 1));
                    if (!mounted) return;
                    Navigator.pop(context);
                  },
                  child: const Text('Simpan'),
                );
              }),
              const SizedBox(
                height: 20.0,
              ),
              BlocBuilder<CrudUserBloc, CrudUserState>(
                  builder: (context, state) {
                return ElevatedButton(
                  onPressed: () async {
                    context
                        .read<CrudUserBloc>()
                        .add(OnDeleteUser(widget.user.id));

                    String message = '';
                    if (state is CrudUserLoading) {
                      message = 'Loading...';
                    } else if (state is CrudUserError) {
                      message = state.message;
                    } else if (state is CrudUserHasData) {
                      message = 'Data deleted Success';
                    }
                    await Future.delayed(const Duration(seconds: 2));
                    if (!mounted) return;
                    ScaffoldMessenger.of(context)
                        .showSnackBar(SnackBar(content: Text(message)));
                    await Future.delayed(const Duration(seconds: 1));
                    if (!mounted) return;
                    Navigator.pop(context);
                  },
                  child: const Text('Hapus Pengguna'),
                );
              }),
            ],
          )),
        ),
      ),
    );
  }
}

extension EmailValidator on String {
  bool isValidEmail() {
    return RegExp(
            r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
        .hasMatch(this);
  }
}
