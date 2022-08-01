import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:netflix/application/search/search_bloc.dart';
import 'package:netflix/core/colors/colors.dart';
import 'package:netflix/core/constants.dart';
import 'package:netflix/core/strings.dart';
import 'package:netflix/presentation/search/widgets/title.dart';

class SearchIdle extends StatelessWidget {
  const SearchIdle({Key? key}) : super(key: key);

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
              return state.isLoading
                  ? const Center(
                      child: CircularProgressIndicator(
                        color: kRedcolor,
                      ),
                    )
                  : state.isError
                      ? const Center(
                          child: Text('Error Occured'),
                        )
                      : state.idleList.isEmpty
                          ? const Center(
                              child: Text('List Is Empty'),
                            )
                          : ListView.separated(
                              physics: const BouncingScrollPhysics(),
                              shrinkWrap: true,
                              itemBuilder: (context, index) {
                                final movie = state.idleList[index];
                                return TopSearchItem(
                                    imageUrl: movie.backDropPath ?? '',
                                    title: movie.title ?? 'No tittle');
                              },
                              separatorBuilder: (context, index) => kHeight20,
                              itemCount: state.idleList.length,
                            );
            },
          ),
        )
      ],
    );
  }
}

class TopSearchItem extends StatelessWidget {
  final String title;
  final String imageUrl;
  const TopSearchItem({
    Key? key,
    required this.imageUrl,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Row(
      children: [
        Container(
          width: size.width * .4,
          height: 85,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: NetworkImage('$imageAppendUrl$imageUrl'),
              fit: BoxFit.cover,
            ),
            borderRadius: BorderRadius.circular(5),
          ),
        ),
        kHeight,
        kWidth,
        Expanded(
          child: Text(
            title,
            style: const TextStyle(fontSize: 18),
          ),
        ),
        const Icon(
          Icons.play_circle_outline,
          color: kWhitecolor,
          size: 45,
        )
      ],
    );
  }
}
