import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:netflix/application/search/search_bloc.dart';
import 'package:netflix/core/colors/colors.dart';
import 'package:netflix/core/constants.dart';
import 'package:netflix/domain/core/debounce/debounce.dart';
import 'package:netflix/presentation/search/widgets/search_idle.dart';
import 'package:netflix/presentation/search/widgets/search_result.dart';

class ScreenSearch extends StatelessWidget {
  const ScreenSearch({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback(
      (_) {
        BlocProvider.of<SearchBloc>(context).add(
          const Initialize(),
        );
      },
    );
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          children: [
            kHeight,
            SearchBar(),
            kHeight,
            Expanded(
              child: BlocBuilder<SearchBloc, SearchState>(
                builder: (context, state) {
                  return state.searchResultList.isEmpty
                      ? const SearchIdle()
                      : const SearchResultWidget();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SearchBar extends StatelessWidget {
  SearchBar({
    Key? key,
  }) : super(key: key);

  final _debouncer = Debouncer(milliseconds: 1 * 10);

  @override
  Widget build(BuildContext context) {
    return CupertinoSearchTextField(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      backgroundColor: kGreycolor.withOpacity(.16),
      suffixIcon: const Icon(
        CupertinoIcons.xmark_circle_fill,
        color: kGreycolor,
      ),
      prefixIcon: const Icon(
        CupertinoIcons.search,
        color: kGreycolor,
      ),
      style: const TextStyle(
        color: kWhitecolor,
      ),
      onChanged: (query) {
        if (query.isEmpty) {
          return;
        } else {
          _debouncer.run(
            () {
              BlocProvider.of<SearchBloc>(context).add(
                SearchMovie(movieQuery: query),
              );
            },
          );
        }
      },
    );
  }
}
