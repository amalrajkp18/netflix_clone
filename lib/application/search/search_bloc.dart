import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:netflix/domain/core/failures/main_failure.dart';
import 'package:netflix/domain/downloads/download_service.dart';
import 'package:netflix/domain/downloads/models/downloads.dart';
import 'package:netflix/domain/search/models/search_resp.dart';
import 'package:netflix/domain/search/search_service.dart';
part 'search_event.dart';
part 'search_state.dart';
part 'search_bloc.freezed.dart';

@injectable
class SearchBloc extends Bloc<SearchEvent, SearchState> {
  final SearchService _serchService;
  final DownloadService _downloadService;
  SearchBloc(this._serchService, this._downloadService)
      : super(SearchState.initial()) {
    /* idle State */
    on<Initialize>((event, emit) async {
      if (state.idleList.isNotEmpty) {
        emit(
          state.copyWith(
            searchResultList: [],
            idleList: state.idleList,
            isLoading: false,
            isError: false,
          ),
        );
        return;
      }

      emit(
        state.copyWith(
          searchResultList: [],
          idleList: [],
          isLoading: true,
          isError: false,
        ),
      );
      //get trending

      // show to ui

      final dData = await _downloadService.getDownloadsImages();

      final data = dData.fold(
        (MainFailure failure) {
          return state.copyWith(
            searchResultList: [],
            idleList: [],
            isLoading: false,
            isError: true,
          );
        },
        (List<Downloads> download) {
          return state.copyWith(
            searchResultList: [],
            idleList: download,
            isLoading: false,
            isError: false,
          );
        },
      );

      emit(data);
    });
/* search result state */
    on<SearchMovie>((event, emit) async {
      emit(
        state.copyWith(
          searchResultList: [],
          idleList: [],
          isLoading: true,
          isError: false,
        ),
      );
      // call search api
      final result =
          await _serchService.searchMovies(movieQuery: event.movieQuery);

      // show to api

      final data = result.fold(
        (MainFailure failure) {
          return state.copyWith(
            searchResultList: [],
            idleList: [],
            isLoading: true,
            isError: false,
          );
        },
        (SearchResp respones) {
          return state.copyWith(
            searchResultList: respones.results,
            idleList: [],
            isLoading: false,
            isError: false,
          );
        },
      );

      emit(data);
    });
  }
}
