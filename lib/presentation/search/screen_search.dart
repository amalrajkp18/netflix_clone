import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:netflix/application/search/search_bloc.dart';
import 'package:netflix/core/constants.dart';
import 'package:netflix/presentation/search/widget/screen_idle.dart';
import 'package:netflix/presentation/search/widget/screen_result.dart';

class ScreenSearch extends StatelessWidget {
  const ScreenSearch({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      BlocProvider.of<SearchBloc>(context).add(const Initialize());
    });
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CupertinoSearchTextField(
                backgroundColor: Colors.grey.withOpacity(0.4),
                prefixIcon: const Icon(
                  CupertinoIcons.search,
                  color: Colors.grey,
                ),
                style: const TextStyle(color: Colors.white),
                suffixIcon: const Icon(
                  CupertinoIcons.xmark_circle_fill,
                  color: Colors.grey,
                ),
                onChanged: (value) {
                  BlocProvider.of<SearchBloc>(context).add(
                    SearchMovie(movieQuery: value),
                  );
                },
              ),
              kHeight,
              Expanded(
                child: BlocBuilder<SearchBloc, SearchState>(
                  builder: (context, state) {
                    if (state.searchResultList.isEmpty) {
                      return const ScreenIdleWidget();
                    } else {
                      return const SearchResultWidget();
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
