import 'package:flutter/material.dart';

class ErrorPage extends StatelessWidget {
  final String message;
  const ErrorPage({Key? key, required this.message}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        if (constraints.maxWidth > 600) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Image(
                    image: AssetImage('assets/github_lost.png'), width: 350),
                Text(
                  message,
                  style: Theme.of(context).textTheme.headline5,
                ),
              ],
            ),
          );
        } else {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Image(
                    image: AssetImage('assets/github_lost.png'), width: 200),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  message,
                  style: Theme.of(context).textTheme.headline5,
                ),
              ],
            ),
          );
        }
      },
    );
  }
}
