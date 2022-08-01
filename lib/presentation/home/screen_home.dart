import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:netflix/core/constants.dart';
import 'package:netflix/presentation/home/widget/background_card.dart';
import 'package:netflix/presentation/home/widget/number_title_card.dart';
import 'package:netflix/presentation/widget/main_title_card.dart';

ValueNotifier<bool> scrollNotifier = ValueNotifier(true);

class ScreenHome extends StatelessWidget {
  const ScreenHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                  ListView(
                    children: const [
                      BackgroundCard(),
                      kHeight,
                      MainTitleCard(
                        title: 'Released in the Past Year',
                      ),
                      kHeight,
                      MainTitleCard(
                        title: 'Trending Now',
                      ),
                      kHeight,
                      NumberTitleCard(),
                      kHeight,
                      MainTitleCard(
                        title: 'Tense Dramas',
                      ),
                      kHeight,
                      MainTitleCard(
                        title: 'South Indian Cinema',
                      ),
                    ],
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
