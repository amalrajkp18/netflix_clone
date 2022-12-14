import 'package:flutter/material.dart';
import 'package:netflix/core/constants.dart';

class AppBarWidget extends StatelessWidget {
  const AppBarWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Text(
          'Downloads',
          style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
        ),
        const Spacer(),
        const Icon(
          Icons.cast,
          color: Colors.white,
          size: 28,
        ),
        kWidth,
        Container(
          width: 25,
          height: 25,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4),
            image: const DecorationImage(
                image: AssetImage('assets/images/ntAvatar.png'),
                fit: BoxFit.cover),
          ),
        ),
        kWidth,
      ],
    );
  }
}
