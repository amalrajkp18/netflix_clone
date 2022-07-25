import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:netflix/application/search/search_bloc.dart';
import 'package:netflix/core/colors/colors.dart';
import 'package:netflix/core/constants.dart';
import 'package:netflix/core/strings.dart';
import 'package:netflix/presentation/search/widget/title.dart';

class ScreenIdleWidget extends StatelessWidget {
  const ScreenIdleWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const ScreenTitle(title: 'Top Searches'),
        kHeight,
        Expanded(
          child: BlocBuilder<SearchBloc, SearchState>(
            builder: (context, state) {
              if (state.isLoading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (state.isError) {
                return const Center(
                  child: Text('Error while getting data'),
                );
              } else if (state.idleList.isEmpty) {
                return const Center(
                  child: Text('List is empty'),
                );
              }
              return ListView.separated(
                shrinkWrap: true,
                itemBuilder: (ctx, index) {
                  final movie = state.idleList[index];
                  return TopserachTileItem(
                    title: movie.title ?? 'No title provided',
                    imageUrl: '$imageAppendUrl${movie.backdropPath}',
                  );
                },
                separatorBuilder: (ctx, index) => kHeight20,
                itemCount: state.idleList.length,
              );
            },
          ),
        )
      ],
    );
  }
}

class TopserachTileItem extends StatelessWidget {
  final String title;
  final String imageUrl;
  const TopserachTileItem({
    Key? key,
    required this.title,
    required this.imageUrl,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screeWidth = MediaQuery.of(context).size.width;
    return Row(
      children: [
        Container(
          width: screeWidth * 0.4,
          height: 70,
          decoration: BoxDecoration(
            image: DecorationImage(
              fit: BoxFit.cover,
              image: NetworkImage(imageUrl),
            ),
            borderRadius: BorderRadius.circular(3),
          ),
        ),
        kWidth,
        Expanded(
          child: Text(
            title,
            style: const TextStyle(
              color: kWhitecolor,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const CircleAvatar(
          backgroundColor: kWhitecolor,
          radius: 20,
          child: CircleAvatar(
            backgroundColor: kBlackcolor,
            radius: 18,
            child: Center(
              child: Icon(
                CupertinoIcons.play_fill,
                color: kWhitecolor,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
