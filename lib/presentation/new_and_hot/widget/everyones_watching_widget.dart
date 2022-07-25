import 'package:flutter/material.dart';
import 'package:netflix/core/colors/colors.dart';
import 'package:netflix/core/constants.dart';
import 'package:netflix/presentation/home/widget/custom_buttom_widget.dart';
import 'package:netflix/presentation/widget/video_widget.dart';

class EveryonesWatchingWidget extends StatelessWidget {
  const EveryonesWatchingWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        kHeight,
        const Text(
          'Friends',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        kHeight,
        const Text(
          'This hit sectiom follows the merry misadventures of six\n20-something palls as they navigate the pitfails of\nwork,life and love in 1990s Manhattan.',
          style: TextStyle(
            color: kGreycolor,
          ),
        ),
        kHeight50,
        const VideoWidget(
          image: kHotNewtempimage2,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: const [
              CustomButton(
                icon: Icons.share,
                title: 'Share',
                textcolor: kGreycolor,
                fontsize: 10,
                iconsize: 35,
              ),
              kWidth,
              CustomButton(
                icon: Icons.add,
                title: 'My List',
                textcolor: kGreycolor,
                fontsize: 10,
                iconsize: 35,
              ),
              kWidth,
              CustomButton(
                icon: Icons.play_arrow,
                title: 'play',
                textcolor: kGreycolor,
                fontsize: 10,
                iconsize: 35,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
