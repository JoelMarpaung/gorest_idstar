import 'package:core/routes/routes.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:user/presentation/bloc/get_user_bloc/get_user_event.dart';
import 'package:user/presentation/bloc/get_user_bloc/get_user_state.dart';

import '../bloc/get_user_bloc/get_user_bloc.dart';
import '../widgets/user_card_widget.dart';

class HomeUserPage extends StatefulWidget {
  const HomeUserPage({Key? key}) : super(key: key);

  @override
  State<HomeUserPage> createState() => _HomeUserPageState();
}

class _HomeUserPageState extends State<HomeUserPage> {
  @override
  void initState() {
    super.initState();
    context.read<GetUserBloc>().add(const OnGetUser());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Gorest - IDStar'),
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.pushNamed(context, addUser, arguments: (route) => false);
          },
          child: const Icon(Icons.add)),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              onChanged: (query) {
                if(query != ''){
                  context.read<GetUserBloc>().add(OnSearchUser(query));
                }else{
                  context.read<GetUserBloc>().add(const OnGetUser());
                }

              },
              decoration: const InputDecoration(
                hintText: 'Search user',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
              ),
              textInputAction: TextInputAction.search,
            ),
            const SizedBox(height: 16),
            const Text(
              'Search Result',
            ),
            BlocBuilder<GetUserBloc, GetUserState>(
              builder: (context, state) {
                if (state is GetUserLoading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state is GetUserHasData) {
                  final result = state.result;
                  return Expanded(
                    child: ListView.builder(
                      padding: const EdgeInsets.all(8),
                      itemBuilder: (context, index) {
                        final user = result[index];
                        return UserCard(user);
                      },
                      itemCount: result.length,
                    ),
                  );
                } else if (state is GetUserError) {
                  return Expanded(
                    child: Center(
                      child: Text(state.message),
                    ),
                  );
                } else {
                  return Expanded(
                    child: Container(),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
