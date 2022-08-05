import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:netflix/application/home/home_bloc.dart';
import 'package:netflix/core/colors/colors.dart';
import 'package:netflix/core/constants.dart';
import 'package:netflix/core/strings.dart';
import 'package:netflix/presentation/home/widget/background_card.dart';
import 'package:netflix/presentation/home/widget/number_title_card.dart';
import 'package:netflix/presentation/widget/main_title_card.dart';

ValueNotifier<bool> scrollNotifier = ValueNotifier(true);

class ScreenHome extends StatelessWidget {
  const ScreenHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      BlocProvider.of<HomeBloc>(context).add(const GetHomeScreenData());
    });
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ValueListenableBuilder(
          valueListenable: scrollNotifier,
          builder: (BuildContext context, index, _) {
            return NotificationListener<UserScrollNotification>(
              onNotification: ((notification) {
                final ScrollDirection direction = notification.direction;
                if (direction == ScrollDirection.reverse) {
                  scrollNotifier.value = false;
                } else if (direction == ScrollDirection.forward) {
                  scrollNotifier.value = true;
                }
                return true;
              }),
              child: Stack(
                children: [
                  BlocBuilder<HomeBloc, HomeState>(
                    builder: (context, state) {
                      if (state.isLoading) {
                        return const Center(
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            color: kRedcolor,
                          ),
                        );
                      }
                      if (state.isError) {
                        return const Center(
                          child: Text('Error ocures'),
                        );
                      }

                      // released in past year
                      final _releasedPastYear =
                          state.pastYearMovieList.map((m) {
                        return '$imageAppendUrl${m.posterPath}';
                      }).toList();

                      // trending now
                      final _trendingNow = state.trendingMovieList.map((m) {
                        return '$imageAppendUrl${m.posterPath}';
                      }).toList();

                      // tense daramas
                      final _tenseDaramas = state.tenseDramaMovieList.map((m) {
                        return '$imageAppendUrl${m.posterPath}';
                      }).toList();

                      // south indian cinema
                      final _southIndianCinema =
                          state.southIndianMovieList.map((m) {
                        return '$imageAppendUrl${m.posterPath}';
                      }).toList();

                      //top 10 tv shows
                      final _top10TvShows = state.trendingTvList.map((t) {
                        return '$imageAppendUrl${t.posterPath}';
                      }).toList();

                      return ListView(
                        children: [
                          BackgroundCard(
                            imageUrl: _trendingNow,
                          ),
                          kHeight,
                          MainTitleCard(
                            title: 'Released in the Past Year',
                            postersList: _releasedPastYear,
                          ),
                          kHeight,
                          MainTitleCard(
                            title: 'Trending Now',
                            postersList: _trendingNow,
                          ),
                          kHeight,
                          NumberTitleCard(
                            postersList: _top10TvShows,
                          ),
                          kHeight,
                          MainTitleCard(
                            title: 'Tense Dramas',
                            postersList: _tenseDaramas,
                          ),
                          kHeight,
                          MainTitleCard(
                            title: 'South Indian Cinema',
                            postersList: _southIndianCinema,
                          ),
                        ],
                      );
                    },
                  ),
                  scrollNotifier.value == true
                      ? AnimatedContainer(
                          duration: const Duration(milliseconds: 1000),
                          width: double.infinity,
                          height: 85,
                          color: Colors.black.withOpacity(0.3),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Image.asset(
                                    'assets/images/logo.png',
                                    width: 50,
                                    height: 50,
                                  ),
                                  const Spacer(),
                                  const Icon(
                                    Icons.cast,
                                    color: Colors.white,
                                    size: 28,
                                  ),
                                  kWidth,
                                  Container(
                                    width: 25,
                                    height: 25,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(4),
                                      image: const DecorationImage(
                                          image: AssetImage(
                                              'assets/images/ntAvatar.png'),
                                          fit: BoxFit.cover),
                                    ),
                                  ),
                                  kWidth,
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Text('Tv Shows', style: kHomeTitleText),
                                  Text('Movies', style: kHomeTitleText),
                                  Text('Categories', style: kHomeTitleText),
                                ],
                              )
                            ],
                          ),
                        )
                      : kHeight,
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
