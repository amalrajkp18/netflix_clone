import 'package:flutter/material.dart';
import 'package:netflix/core/colors/colors.dart';

class VideoWidget extends StatelessWidget {
  const VideoWidget({
    Key? key,
    required this.image,
  }) : super(key: key);
  final String image;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SizedBox(
          width: double.infinity,
          height: 200,
          child: Image.network(
            image,
            fit: BoxFit.cover,
            loadingBuilder:
                (BuildContext _, Widget child, ImageChunkEvent? progress) {
              if (progress == null) {
                return child;
              } else {
                return const Center(
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    color: kRedcolor,
                  ),
                );
              }
            },
            errorBuilder: (BuildContext _, Object obj, StackTrace? trace) {
              return const Center(
                child: Icon(
                  Icons.sync_problem,
                  color: kWhitecolor,
                  size: 60,
                ),
              );
            },
          ),
        ),
        Positioned(
          bottom: 10,
          right: 10,
          child: CircleAvatar(
            radius: 18,
            backgroundColor: kGreycolor.withOpacity(0.6),
            child: IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.volume_off_outlined,
                size: 18,
                color: kWhitecolor,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
