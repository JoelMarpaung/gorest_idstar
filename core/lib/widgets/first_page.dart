import 'package:flutter/material.dart';

class FirstPage extends StatelessWidget {
  final String message;
  const FirstPage({Key? key, required this.message}) : super(key: key);

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
                    image: AssetImage('assets/github_first.png'), width: 350),
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
                    image: AssetImage('assets/github_first.png'), width: 200),
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
