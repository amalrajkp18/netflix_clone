import 'package:flutter/material.dart';
import 'package:netflix/application/fast_laugh/fast_laugh_bloc.dart';
import 'package:netflix/core/colors/colors.dart';
import 'package:netflix/core/strings.dart';
import 'package:netflix/domain/downloads/models/downloads.dart';
import 'package:share_plus/share_plus.dart';
import 'package:video_player/video_player.dart';

class VideoListItemInheritedWidget extends InheritedWidget {
  final Widget widget;
  final Downloads movieData;

  const VideoListItemInheritedWidget({
    Key? key,
    required this.widget,
    required this.movieData,
  }) : super(key: key, child: widget);

  @override
  bool updateShouldNotify(covariant VideoListItemInheritedWidget oldWidget) {
    return oldWidget.movieData != movieData;
  }

  static VideoListItemInheritedWidget? of(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<VideoListItemInheritedWidget>();
  }
}

class VideoListItem extends StatelessWidget {
  final int index;
  const VideoListItem({
    Key? key,
    required this.index,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ValueNotifier<Set<int>> likedVideoIdNotifier = ValueNotifier({});
    final ValueNotifier<Set<int>> myListVideoIdNotifier = ValueNotifier({});

    final posterPath =
        VideoListItemInheritedWidget.of(context)?.movieData.posterPath;
    final videoUrl = dummyVideoUrls[index % dummyVideoUrls.length];
    return Stack(
      children: [
        FastLaughVideoPlayer(
          videoUrl: videoUrl,
          onStateChanged: (bool) {},
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                //Leftside
                CircleAvatar(
                  backgroundColor: kGreycolor.withOpacity(.3),
                  radius: 20,
                  child: const Icon(
                    Icons.volume_off,
                    color: kBlackcolor,
                  ),
                ),
                //Right side
                Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: CircleAvatar(
                        radius: 30,
                        backgroundImage: posterPath == null
                            ? null
                            : NetworkImage('$imageAppendUrl$posterPath'),
                      ),
                    ),
                    ValueListenableBuilder(
                      valueListenable: likedVideoIdNotifier,
                      builder: (BuildContext ctx, Set<int> newLikedListIds,
                          Widget? _) {
                        final _index = index;
                        if (newLikedListIds.contains(_index)) {
                          return GestureDetector(
                            onTap: () {
                              likedVideoIdNotifier.value.remove(_index);
                              likedVideoIdNotifier.notifyListeners();
                            },
                            child: const VideoActionsWidget(
                              icon: Icons.favorite,
                              title: 'Liked',
                              color: kRedcolor,
                            ),
                          );
                        }
                        return GestureDetector(
                          onTap: () {
                            likedVideoIdNotifier.value.add(_index);
                            likedVideoIdNotifier.notifyListeners();
                          },
                          child: const VideoActionsWidget(
                              icon: Icons.emoji_emotions, title: 'LOL'),
                        );
                      },
                    ),
                    ValueListenableBuilder(
                        valueListenable: myListVideoIdNotifier,
                        builder: (BuildContext ctx, Set<int> newMyListIds,
                            Widget? _) {
                          final _index = index;
                          if (newMyListIds.contains(_index)) {
                            return GestureDetector(
                              onTap: () {
                                myListVideoIdNotifier.value.remove(_index);
                                myListVideoIdNotifier.notifyListeners();
                              },
                              child: const VideoActionsWidget(
                                  icon: Icons.check_circle_outline,
                                  title: 'My List'),
                            );
                          }
                          return GestureDetector(
                            onTap: () {
                              myListVideoIdNotifier.value.add(_index);
                              myListVideoIdNotifier.notifyListeners();
                            },
                            child: const VideoActionsWidget(
                                icon: Icons.add, title: 'My List'),
                          );
                        }),
                    GestureDetector(
                      onTap: () {
                        final _shareMovie =
                            VideoListItemInheritedWidget.of(context)
                                ?.movieData
                                .posterPath;
                        if (_shareMovie != null) {
                          Share.share(_shareMovie);
                        }
                      },
                      child: const VideoActionsWidget(
                          icon: Icons.share, title: 'Share'),
                    ),
                    const VideoActionsWidget(icon: Icons.pause, title: 'Pause'),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class VideoActionsWidget extends StatelessWidget {
  final IconData icon;
  final String title;
  final Color color;
  const VideoActionsWidget({
    Key? key,
    required this.icon,
    required this.title,
    this.color = kWhitecolor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: Column(
        children: [
          Icon(
            icon,
            color: color,
            size: 30,
          ),
          Text(
            title,
            style: const TextStyle(
              color: kWhitecolor,
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }
}

class FastLaughVideoPlayer extends StatefulWidget {
  final String videoUrl;
  final void Function(bool isPlaying) onStateChanged;
  const FastLaughVideoPlayer({
    Key? key,
    required this.videoUrl,
    required this.onStateChanged,
  }) : super(key: key);

  @override
  State<FastLaughVideoPlayer> createState() => _FastLaughVideoPlayerState();
}

class _FastLaughVideoPlayerState extends State<FastLaughVideoPlayer> {
  late VideoPlayerController _videoPlayerController;

  @override
  void initState() {
    _videoPlayerController = VideoPlayerController.network(widget.videoUrl);
    _videoPlayerController.initialize().then((value) {
      setState(() {});
      _videoPlayerController.play();
      _videoPlayerController.setLooping(true);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: double.infinity,
      child: _videoPlayerController.value.isInitialized
          ? AspectRatio(
              aspectRatio: _videoPlayerController.value.aspectRatio,
              child: VideoPlayer(_videoPlayerController),
            )
          : const Center(
              child: CircularProgressIndicator(
                strokeWidth: 2,
                color: kRedcolor,
              ),
            ),
    );
  }

  @override
  void dispose() {
    _videoPlayerController.dispose();
    super.dispose();
  }
}
