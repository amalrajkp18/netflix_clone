import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:netflix/application/hot_and_new/hot_and_new_bloc.dart';
import 'package:netflix/core/colors/colors.dart';
import 'package:netflix/core/constants.dart';
import 'package:netflix/core/strings.dart';
import 'package:netflix/presentation/home/widget/custom_buttom_widget.dart';
import 'package:netflix/presentation/widget/video_widget.dart';

class ComingSoonList extends StatelessWidget {
  const ComingSoonList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      BlocProvider.of<HotAndNewBloc>(context).add(const LoadDataInComingSoon());
    });
    return RefreshIndicator(
      onRefresh: () async {
        BlocProvider.of<HotAndNewBloc>(context)
            .add(const LoadDataInComingSoon());
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
          } else if (state.comingSoonList.isEmpty) {
            return const Center(
              child: Text('ComingSoon List is Empty'),
            );
          } else {
            return ListView.builder(
              itemCount: state.comingSoonList.length,
              itemBuilder: (BuildContext context, index) {
                final movie = state.comingSoonList[index];
                String month = '';
                String date = '';
                try {
                  final _date = DateTime.tryParse(movie.releaseDate!);
                  final formatedDate = DateFormat.MMMMd().format(_date!);
                  month = formatedDate;
                  date = movie.releaseDate!.split('-')[1];
                } catch (_) {
                  month = '';
                  date = '';
                }
                return ComingSoonWidget(
                    id: movie.id.toString(),
                    month: month,
                    date: date,
                    backdropPath: '$imageAppendUrl${movie.backdropPath}',
                    movieName: movie.title ?? 'No Title',
                    description: movie.overview ?? 'No Description');
              },
            );
          }
        },
      ),
    );
  }
}

class ComingSoonWidget extends StatelessWidget {
  final String id;
  final String month;
  final String date;
  final String backdropPath;
  final String movieName;
  final String description;
  const ComingSoonWidget({
    Key? key,
    required this.id,
    required this.month,
    required this.date,
    required this.backdropPath,
    required this.movieName,
    required this.description,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          SizedBox(
            width: 50,
            height: 415,
            child: Column(
              children: [
                Text(
                  month.split(' ').first.substring(0, 3).toUpperCase(),
                  style: const TextStyle(
                      fontSize: 16,
                      color: kGreycolor,
                      fontWeight: FontWeight.bold),
                ),
                Text(
                  date,
                  style: const TextStyle(
                      fontSize: 30,
                      color: kWhitecolor,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 3),
                ),
              ],
            ),
          ),
          SizedBox(
            width: size.width - 50,
            height: 430,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                VideoWidget(
                  image: backdropPath,
                ),
                kHeight,
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        movieName,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 35,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    kWidth,
                    const CustomButton(
                      icon: Icons.notifications_none,
                      title: 'Remind Me',
                      textcolor: kGreycolor,
                      fontsize: 10,
                    ),
                    kWidth,
                    const CustomButton(
                      icon: Icons.info_outline,
                      title: 'Info',
                      textcolor: kGreycolor,
                      fontsize: 10,
                    ),
                    kWidth,
                  ],
                ),
                kHeight,
                Text('Coming on  $month'),
                kHeight,
                Text(
                  movieName,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                kHeight,
                Text(
                  description,
                  maxLines: 5,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: kGreycolor,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
