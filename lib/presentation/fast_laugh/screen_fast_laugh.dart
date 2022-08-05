import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:netflix/application/fast_laugh/fast_laugh_bloc.dart';
import 'package:netflix/core/colors/colors.dart';
import 'package:netflix/presentation/fast_laugh/widget/video_list_item.dart';

class ScreenFastLaugh extends StatelessWidget {
  const ScreenFastLaugh({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback(
      (_) {
        BlocProvider.of<FastLaughBloc>(context).add(
          const Initialize(),
        );
      },
    );
    return Scaffold(
      body: SafeArea(
        child: BlocBuilder<FastLaughBloc, FastLaughState>(
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
                child: Icon(
                  Icons.wifi_off,
                  color: kWhitecolor,
                  size: 60,
                ),
              );
            } else if (state.videoList.isEmpty) {
              return const Center(
                child: Text('Videos Empty'),
              );
            } else {
              return PageView(
                scrollDirection: Axis.vertical,
                children: List.generate(
                  state.videoList.length,
                  (index) {
                    return VideoListItemInheritedWidget(
                      widget: VideoListItem(
                          key: Key(index.toString()), index: index),
                      movieData: state.videoList[index],
                    );
                  },
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
