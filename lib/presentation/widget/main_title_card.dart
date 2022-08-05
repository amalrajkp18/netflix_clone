import 'package:flutter/material.dart';
import 'package:netflix/core/constants.dart';
import 'package:netflix/presentation/widget/main_card.dart';
import 'package:netflix/presentation/widget/main_title.dart';

class MainTitleCard extends StatelessWidget {
  const MainTitleCard({
    Key? key,
    required this.title,
    required this.postersList,
  }) : super(key: key);
  final String title;
  final List<String> postersList;
  @override
  Widget build(BuildContext context) {
    postersList.shuffle();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        MainTitle(title: title),
        kHeight,
        LimitedBox(
          maxHeight: 200,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: List.generate(
              10,
              (index) => MainCard(
                imageUrl: postersList[index],
              ),
            ),
          ),
        )
      ],
    );
  }
}
