import 'package:flutter/material.dart';
import 'package:netflix/core/colors/colors.dart';
import 'package:netflix/core/constants.dart';
import 'package:netflix/presentation/new_and_hot/widget/coming_soon_widget.dart';
import 'package:netflix/presentation/new_and_hot/widget/everyones_watching_widget.dart';

class ScreenNewAndHot extends StatelessWidget {
  const ScreenNewAndHot({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
          appBar: PreferredSize(
            preferredSize: const Size.fromHeight(90),
            child: AppBar(
              title: const Text(
                'New & Hot',
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              ),
              actions: [
                const Icon(
                  Icons.cast,
                  color: Colors.white,
                  size: 28,
                ),
                kWidth,
                Align(
                  child: Container(
                    width: 25,
                    height: 25,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4),
                      image: const DecorationImage(
                          image: AssetImage('assets/images/ntAvatar.png'),
                          fit: BoxFit.cover),
                    ),
                  ),
                ),
                kWidth,
              ],
              bottom: TabBar(
                isScrollable: true,
                labelColor: kBlackcolor,
                unselectedLabelColor: kWhitecolor,
                labelStyle: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
                indicator: BoxDecoration(
                    color: kWhitecolor, borderRadius: kBorderRadius30),
                tabs: const [
                  Tab(
                    text: '🍿 Coming Soon',
                  ),
                  Tab(text: "👀 Everyone's Watching"),
                ],
              ),
            ),
          ),
          body: TabBarView(
            children: [
              _buildComingSoon(context),
              _buildEveryonesWatching(),
            ],
          )),
    );
  }

  _buildComingSoon(BuildContext context) {
    return ListView.builder(
        itemBuilder: (BuildContext context, index) => const ComingSoonWidget(),
        itemCount: 10);
  }

  _buildEveryonesWatching() {
    return ListView.builder(
        itemCount: 10,
        itemBuilder: (BuildContext context, index) =>
            const EveryonesWatchingWidget());
  }
}
