import 'package:core/widgets/shimmer_effect.dart';
import 'package:flutter/material.dart';

class ShimmerListTile extends StatelessWidget {
  const ShimmerListTile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ShimmerLoading(
      isLoading: true,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListTile(
          dense: false,
          leading: Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.circular(5),
            ),
          ),
          title: Container(
            width: double.infinity,
            height: 25,
            decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.circular(5),
            ),
          ),
          trailing: Container(
            width: 25,
            height: 25,
            decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.circular(5),
            ),
          ),
        ),
      ),
    );
  }
}
