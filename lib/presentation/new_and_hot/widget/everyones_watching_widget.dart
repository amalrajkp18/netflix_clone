import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:netflix/application/hot_and_new/hot_and_new_bloc.dart';
import 'package:netflix/core/colors/colors.dart';
import 'package:netflix/core/constants.dart';
import 'package:netflix/core/strings.dart';
import 'package:netflix/presentation/home/widget/custom_buttom_widget.dart';
import 'package:netflix/presentation/widget/video_widget.dart';

class EveryOnesWatchingList extends StatelessWidget {
  const EveryOnesWatchingList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      BlocProvider.of<HotAndNewBloc>(context)
          .add(const LoadDataInEveryOneIsWatching());
    });
    return RefreshIndicator(
      onRefresh: () async {
        BlocProvider.of<HotAndNewBloc>(context)
            .add(const LoadDataInEveryOneIsWatching());
      },
      color: kRedcolor,
      child: BlocBuilder<HotAndNewBloc, HotAndNewState>(
        builder: (context, state) {
          if (state.isLoading) {
            return const Center(
              child: CircularProgressIndicator(
                color: kRedcolor,
                strokeWidth: 2,
              ),
            );
          } else if (state.isError) {
            return const Center(
              child: Text('Error occured'),
            );
          } else if (state.everyOneIsWatchingList.isEmpty) {
            return const Center(
              child: Text('ComingSoon List is Empty'),
            );
          } else {
            return ListView.builder(
              itemCount: state.everyOneIsWatchingList.length,
              itemBuilder: (BuildContext context, index) {
                final tv = state.everyOneIsWatchingList[index];
                return EveryonesWatchingWidget(
                  backdropPath: '$imageAppendUrl${tv.backdropPath}',
                  movieName: tv.originalName ?? 'No name provided',
                  description: tv.overview ?? 'No description',
                );
              },
            );
          }
        },
      ),
    );
  }
}

class EveryonesWatchingWidget extends StatelessWidget {
  final String backdropPath;
  final String movieName;
  final String description;
  const EveryonesWatchingWidget({
    Key? key,
    required this.backdropPath,
    required this.movieName,
    required this.description,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          kHeight,
          Text(
            movieName,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          kHeight,
          Text(
            description,
            style: const TextStyle(
              color: kGreycolor,
            ),
          ),
          kHeight50,
          VideoWidget(
            image: backdropPath,
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
      ),
    );
  }
}
