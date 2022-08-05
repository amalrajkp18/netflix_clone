import 'package:flutter/material.dart';
import 'package:netflix/core/colors/colors.dart';
import 'package:netflix/core/constants.dart';
import 'package:netflix/core/strings.dart';
import 'package:netflix/domain/search/models/search_resp.dart';
import 'package:netflix/presentation/home/widget/custom_buttom_widget.dart';

class MovieInfo extends StatelessWidget {
  const MovieInfo({
    Key? key,
    required this.movieList,
  }) : super(key: key);
  final SearchResultData movieList;

  @override
  Widget build(BuildContext context) {
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
                Positioned(
                  bottom: 10,
                  right: 20,
                  child: Row(
                    children: const [
                      CustomButton(icon: Icons.add, title: 'My List'),
                      kWidth30,
                      CustomButton(icon: Icons.thumb_up_sharp, title: 'Rate'),
                      kWidth30,
                      CustomButton(icon: Icons.share, title: 'Share'),
                    ],
                  ),
                )
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
                  kHeight20,
                  Text(
                    '${movieList.overview}',
                    style: const TextStyle(
                        color: kGreycolor,
                        fontSize: 15,
                        fontWeight: FontWeight.bold),
                  ),
                  kHeight20,
                  Center(
                    child: SizedBox(
                      width: 360,
                      height: 40,
                      child: ElevatedButton.icon(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.play_arrow,
                          color: kBlackcolor,
                          size: 30,
                        ),
                        label: const Text(
                          'Play',
                          style: TextStyle(color: kBlackcolor, fontSize: 20),
                        ),
                        style: TextButton.styleFrom(
                          backgroundColor: kWhitecolor,
                        ),
                      ),
                    ),
                  ),
                  kHeight,
                  Center(
                    child: SizedBox(
                      width: 360,
                      height: 40,
                      child: ElevatedButton.icon(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.download,
                          color: kWhitecolor,
                          size: 25,
                        ),
                        label: const Text(
                          'Download',
                          style: TextStyle(color: kWhitecolor, fontSize: 20),
                        ),
                        style: TextButton.styleFrom(
                          backgroundColor: kGreycolor.withOpacity(0.3),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
