import 'package:core/commons/utils.dart';
import 'package:core/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gorest_idstar/injection.dart' as di;
import 'package:user/domain/entities/user.dart';
import 'package:user/presentation/bloc/crud_user_bloc/crud_user_bloc.dart';
import 'package:user/presentation/bloc/get_user_bloc/get_user_bloc.dart';
import 'package:user/presentation/pages/add_user_page.dart';
import 'package:user/presentation/pages/edit_user_page.dart';
import 'package:user/presentation/pages/home_user_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => di.locator<GetUserBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<CrudUserBloc>(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Gorest - IDStar',
        home: const HomeUserPage(),
        navigatorObservers: [routeObserver],
        onGenerateRoute: (RouteSettings settings) {
          switch (settings.name) {
            case homePage:
              return MaterialPageRoute(builder: (_) => const HomeUserPage());
            case addUser:
              return MaterialPageRoute(builder: (_) => const AddUserPage());
            case editUser:
              final user = settings.arguments as User;
              return MaterialPageRoute(
                builder: (_) => EditUserPage(user: user),
                settings: settings,
              );

            default:
              return MaterialPageRoute(
                builder: (_) {
                  return const Scaffold(
                    body: Center(
                      child: Text('Page not found :('),
                    ),
                  );
                },
              );
          }
        },
      ),
    );
  }
}
