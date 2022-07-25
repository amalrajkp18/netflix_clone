import 'package:bordered_text/bordered_text.dart';
import 'package:flutter/material.dart';
import 'package:netflix/core/colors/colors.dart';
import 'package:netflix/core/constants.dart';

class NumberCard extends StatelessWidget {
  const NumberCard({Key? key, required this.index}) : super(key: key);
  final int index;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Row(
          children: [
            const SizedBox(
              width: 40,
              height: 200,
            ),
            Container(
              width: 130,
              height: 200,
              decoration: BoxDecoration(
                image: const DecorationImage(
                    image: NetworkImage(
                        'https://www.themoviedb.org/t/p/w220_and_h330_face/8VNA0RdrPk8Ec7XVjpeT0Rnui79.jpg'),
                    fit: BoxFit.cover),
                borderRadius: kBorderRadius5,
              ),
            ),
          ],
        ),
        Positioned(
          left: 20,
          bottom: -10,
          child: BorderedText(
            strokeWidth: 6.0,
            strokeColor: kWhitecolor,
            child: Text(
              '${index + 1}',
              style: const TextStyle(
                  fontSize: 110,
                  fontWeight: FontWeight.bold,
                  // decoration: TextDecoration.none,
                  // decorationColor: Colors.white,
                  color: kBlackcolor),
            ),
          ),
        )
      ],
    );
  }
}
