import 'package:flutter/material.dart';
import 'package:netflix/core/constants.dart';

class MainCard extends StatelessWidget {
  const MainCard({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10),
      width: 130,
      height: 250,
      decoration: BoxDecoration(
        image: const DecorationImage(
            image: NetworkImage(
                'https://www.themoviedb.org/t/p/w220_and_h330_face/zPIug5giU8oug6Xes5K1sTfQJxY.jpg'),
            fit: BoxFit.cover),
        borderRadius: kBorderRadius5,
      ),
    );
  }
}
