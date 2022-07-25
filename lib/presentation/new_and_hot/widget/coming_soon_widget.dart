import 'package:flutter/material.dart';
import 'package:netflix/core/colors/colors.dart';
import 'package:netflix/core/constants.dart';
import 'package:netflix/presentation/home/widget/custom_buttom_widget.dart';
import 'package:netflix/presentation/widget/video_widget.dart';

class ComingSoonWidget extends StatelessWidget {
  const ComingSoonWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          SizedBox(
            width: 50,
            height: 415,
            child: Column(
              children: const [
                Text(
                  'FEB',
                  style: TextStyle(
                      fontSize: 16,
                      color: kGreycolor,
                      fontWeight: FontWeight.bold),
                ),
                Text(
                  '11',
                  style: TextStyle(
                      fontSize: 30,
                      color: kWhitecolor,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 3),
                ),
              ],
            ),
          ),
          SizedBox(
            width: size.width - 50,
            height: 415,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const VideoWidget(
                  image: kHotNewtempimage1,
                ),
                kHeight,
                Row(
                  // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    Text(
                      'TALL GIRL 2',
                      style:
                          TextStyle(fontSize: 35, fontWeight: FontWeight.bold),
                    ),
                    Spacer(),
                    CustomButton(
                      icon: Icons.notifications_none,
                      title: 'Remind Me',
                      textcolor: kGreycolor,
                      fontsize: 10,
                    ),
                    kWidth,
                    CustomButton(
                      icon: Icons.info_outline,
                      title: 'Info',
                      textcolor: kGreycolor,
                      fontsize: 10,
                    ),
                    kWidth,
                  ],
                ),
                kHeight,
                const Text('Coming on Friday'),
                kHeight,
                const Text(
                  'TALL GIRL 2',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                kHeight,
                const Text(
                  'Landing the lead int school musical is a \ndream come true for jodi, until the pressure \nsends her confidenc- and her relationship - \ninto a tailspain',
                  style: TextStyle(
                    color: kGreycolor,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
