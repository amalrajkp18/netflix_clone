import 'package:flutter/material.dart';
import 'package:netflix/core/colors/colors.dart';
import 'package:netflix/core/strings.dart';
import 'package:netflix/presentation/home/widget/custom_buttom_widget.dart';

class BackgroundCard extends StatelessWidget {
  const BackgroundCard({
    Key? key,
    required this.imageUrl,
  }) : super(key: key);

  final List<String> imageUrl;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: double.infinity,
          height: 600,
          decoration: BoxDecoration(
            image: DecorationImage(
                image: NetworkImage('$imageAppendUrl${imageUrl[0]}'),
                fit: BoxFit.cover),
          ),
        ),
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: Padding(
            padding: const EdgeInsets.only(bottom: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                const CustomButton(
                  icon: Icons.add,
                  title: 'My List',
                ),
                _playButton(),
                const CustomButton(
                  icon: Icons.info_outline,
                  title: 'Info',
                ),
              ],
            ),
          ),
        )
      ],
    );
  }

  TextButton _playButton() {
    return TextButton.icon(
      style:
          ButtonStyle(backgroundColor: MaterialStateProperty.all(kWhitecolor)),
      onPressed: () {},
      icon: const Icon(
        Icons.play_arrow,
        color: kBlackcolor,
        size: 30,
      ),
      label: const Padding(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: Text(
          'Play',
          style: TextStyle(color: kBlackcolor, fontSize: 20),
        ),
      ),
    );
  }
}
