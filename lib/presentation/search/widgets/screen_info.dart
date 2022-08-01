import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:netflix/application/search/search_bloc.dart';
import 'package:netflix/core/colors/colors.dart';
import 'package:netflix/core/constants.dart';
import 'package:netflix/core/strings.dart';
import 'package:netflix/domain/search/models/search_resp.dart';

class MovieInfo extends StatelessWidget {
  const MovieInfo({
    Key? key,
    required this.movieList,
  }) : super(key: key);
  final SearchResultData movieList;
  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback(
      (_) {
        BlocProvider.of<SearchBloc>(context).add(
          const Initialize(),
        );
      },
    );
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                SizedBox(
                  width: size.width,
                  height: 390,
                  child: Column(
                    children: [
                      kHeight,
                      Row(
                        children: [
                          Stack(
                            children: [
                              Container(
                                width: size.width,
                                height: 300,
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: NetworkImage(
                                        '$imageAppendUrl${movieList.backdropPath}'),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ],
                  ),
                ),
                Positioned(
                  bottom: 0,
                  left: 20,
                  child: Container(
                    width: 130,
                    height: 200,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      image: DecorationImage(
                        image: NetworkImage(
                            '$imageAppendUrl${movieList.posterPath}'),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                const Positioned(
                  bottom: 35,
                  right: 20,
                  child: Icon(
                    Icons.play_circle_rounded,
                    color: kRedcolor,
                    size: 65,
                  ),
                ),
              ],
            ),
            kHeight,
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${movieList.title}',
                    style: const TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: kWhitecolor,
                    ),
                  ),
                  kHeight,
                  Text(
                    'Overview',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: kWhitecolor.withOpacity(0.8),
                    ),
                  ),
                  kHeight,
                  Text(
                    '${movieList.overview}',
                    style: const TextStyle(
                        color: kGreycolor,
                        fontSize: 15,
                        fontWeight: FontWeight.bold),
                  ),
                  kHeight20,
                  const Text(
                    'More Like This',
                    style: TextStyle(color: kWhitecolor, fontSize: 18),
                  ),
                  kHeight,
                  const SuuggestionList(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SuuggestionList extends StatelessWidget {
  const SuuggestionList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SearchBloc, SearchState>(
      builder: (context, state) {
        return LimitedBox(
            maxHeight: 190,
            child: ListView(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              children: List.generate(
                state.idleList.length,
                (index) {
                  final movie = state.idleList[index];
                  return SuggestionCard(image: '${movie.posterPath}');
                },
              ),
            ));
      },
    );
  }
}

class SuggestionCard extends StatelessWidget {
  const SuggestionCard({Key? key, required this.image}) : super(key: key);
  final String image;

  @override
  Widget build(BuildContext context) {
    return image.endsWith('.jpg')
        ? Container(
            margin: const EdgeInsets.symmetric(horizontal: 10),
            width: 130,
            height: 250,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage('$imageAppendUrl$image'),
                fit: BoxFit.cover,
              ),
              borderRadius: kBorderRadius5,
            ),
          )
        : const Center(
            child: Text(
              'Image \nnot found',
              textAlign: TextAlign.center,
            ),
          );
  }
}
