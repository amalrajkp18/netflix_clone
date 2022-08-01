import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:netflix/application/downloads/downloads_bloc.dart';
import 'package:netflix/core/colors/colors.dart';
import 'package:netflix/core/constants.dart';
import 'package:netflix/core/strings.dart';
import 'package:netflix/presentation/widget/app_bar_widget.dart';

class ScreenDownloads extends StatelessWidget {
  ScreenDownloads({Key? key}) : super(key: key);
  final _widgetList = [
    const _SectionOne(),
    const _SectionTwo(),
    const _SectionThree(),
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: const PreferredSize(
          preferredSize: Size.fromHeight(60),
          child: AppBarWidget(),
        ),
        body: ListView.separated(
            padding: const EdgeInsets.all(20),
            itemBuilder: (ctx, index) => _widgetList[index],
            separatorBuilder: (ctx, index) => const SizedBox(height: 20),
            itemCount: _widgetList.length),
      ),
    );
  }
}

class _SectionThree extends StatelessWidget {
  const _SectionThree({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: double.infinity,
          child: MaterialButton(
            color: kButtonColorblue,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5),
            ),
            onPressed: () {},
            child: const Padding(
              padding: EdgeInsets.symmetric(vertical: 10),
              child: Text(
                'Set up',
                style: TextStyle(
                  color: kWhitecolor,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
        kHeight,
        MaterialButton(
          color: kButtonColorwhite,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5),
          ),
          onPressed: () {},
          child: const Padding(
            padding: EdgeInsets.symmetric(vertical: 10),
            child: Text(
              'See what you can download',
              style: TextStyle(
                color: kBlackcolor,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _SectionTwo extends StatelessWidget {
  const _SectionTwo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback(
      (_) {
        BlocProvider.of<DownloadsBloc>(context).add(
          const DownloadsEvent.getDownloadsImage(),
        );
      },
    );
    final Size mediaSize = MediaQuery.of(context).size;
    return Column(
      children: [
        const Text(
          'Introducing Downloads for You',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: kWhitecolor,
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
        // kHeight,
        const Text(
          "We'll download s personalised selection of\nmovies and shows for you,So there's\nalways something to watch on your\ndevice.",
          textAlign: TextAlign.center,
          style: TextStyle(
            color: kGreycolor,
            fontSize: 16,
          ),
        ),
        BlocBuilder<DownloadsBloc, DownloadState>(
          builder: (context, states) {
            return SizedBox(
              width: mediaSize.width,
              height: mediaSize.width,
              child: states.isLoading == true
                  ? const Center(
                      child: CircularProgressIndicator(
                        color: kRedcolor,
                      ),
                    )
                  : states.downloads.isEmpty
                      ? const CircularProgressIndicator(
                          color: kWhitecolor,
                        )
                      : Stack(
                          alignment: Alignment.center,
                          children: [
                            CircleAvatar(
                              backgroundColor: kGreycolor.withOpacity(.35),
                              radius: mediaSize.width * .38,
                            ),
                            DownloadsImageWidget(
                              isLoading: states.isLoading,
                              size: Size(
                                  mediaSize.width * .35, mediaSize.width * .5),
                              image:
                                  '$imageAppendUrl${states.downloads[2].posterPath}',
                              angle: 20,
                              margin: const EdgeInsets.only(left: 160, top: 25),
                            ),
                            DownloadsImageWidget(
                              isLoading: states.isLoading,
                              size: Size(
                                  mediaSize.width * .35, mediaSize.width * .5),
                              image:
                                  '$imageAppendUrl${states.downloads[1].posterPath}',
                              angle: -20,
                              margin:
                                  const EdgeInsets.only(right: 160, top: 25),
                            ),
                            DownloadsImageWidget(
                              size: Size(
                                  mediaSize.width * .42, mediaSize.width * .6),
                              image:
                                  '$imageAppendUrl${states.downloads[0].posterPath}',
                              margin: const EdgeInsets.only(left: 0),
                              isLoading: states.isLoading,
                            )
                          ],
                        ),
            );
          },
        ),
      ],
    );
  }
}

class _SectionOne extends StatelessWidget {
  const _SectionOne({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: const [
        kHeight,
        Icon(
          Icons.settings,
          color: kWhitecolor,
        ),
        kWidth,
        Text(
          'Smart Downloads',
        ),
      ],
    );
  }
}

class DownloadsImageWidget extends StatelessWidget {
  const DownloadsImageWidget(
      {Key? key,
      required this.size,
      required this.image,
      this.angle = 0,
      required this.isLoading,
      required this.margin})
      : super(key: key);
  final String image;
  final Size size;
  final double angle;
  final EdgeInsets margin;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: margin,
      child: Transform.rotate(
        angle: angle * pi / 180,
        child: Container(
          height: size.height,
          width: size.width,
          decoration: BoxDecoration(
            color: isLoading == false ? kGreycolor : Colors.transparent,
            borderRadius: BorderRadius.circular(8),
            image:
                DecorationImage(image: NetworkImage(image), fit: BoxFit.cover),
          ),
        ),
      ),
    );
  }
}
