import 'package:flutter/material.dart';
import 'package:netflix/core/colors/colors.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    Key? key,
    required this.icon,
    required this.title,
    this.iconsize = 30,
    this.fontsize = 16,
    this.textcolor = kWhitecolor,
  }) : super(key: key);
  final IconData icon;
  final String title;
  final double iconsize;
  final double fontsize;
  final Color textcolor;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(
          icon,
          color: kWhitecolor,
          size: iconsize,
        ),
        Text(
          title,
          style: TextStyle(
            color: textcolor,
            fontSize: fontsize,
          ),
        )
      ],
    );
  }
}
