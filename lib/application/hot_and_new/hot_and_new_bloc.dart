import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:netflix/domain/core/failures/main_failure.dart';
import 'package:netflix/domain/hot_and_new/hot_and_new_service.dart';

import '../../domain/hot_and_new/model/hot_and_new_resp.dart';

part 'hot_and_new_event.dart';
part 'hot_and_new_state.dart';
part 'hot_and_new_bloc.freezed.dart';

@injectable
class HotAndNewBloc extends Bloc<HotAndNewEvent, HotAndNewState> {
  final HotAndNewService _hotAndNewService;
  HotAndNewBloc(this._hotAndNewService) : super(HotAndNewState.initial()) {
    /*
    get hotandnew movie data
    */
    on<LoadDataInComingSoon>((event, emit) async {
      // send loading to ui
      emit(
        state.copyWith(
          comingSoonList: [],
          everyOneIsWatchingList: [],
          isLoading: true,
          isError: false,
        ),
      );
      //get data to remote
      final _result = await _hotAndNewService.getHotAndNewMovieData();
      //data to state
      final newState = _result.fold(
        (MainFailure failure) {
          return state.copyWith(
            comingSoonList: [],
            everyOneIsWatchingList: [],
            isLoading: false,
            isError: true,
          );
        },
        (HotAndNewResp response) {
          return state.copyWith(
            comingSoonList: response.results,
            everyOneIsWatchingList: state.everyOneIsWatchingList,
            isLoading: false,
            isError: false,
          );
        },
      );
      // send to ui
      emit(newState);
    });

    /*
    get hotandnew tv data
    */
    on<LoadDataInEveryOneIsWatching>((event, emit) async {
      // send loading to ui
      emit(
        state.copyWith(
          comingSoonList: [],
          everyOneIsWatchingList: [],
          isLoading: true,
          isError: false,
        ),
      );
      //get data to remote
      final _result = await _hotAndNewService.getHotAndNewTvData();
      //data to state
      final newState = _result.fold(
        (MainFailure failure) {
          return state.copyWith(
            comingSoonList: [],
            everyOneIsWatchingList: [],
            isLoading: false,
            isError: true,
          );
        },
        (HotAndNewResp response) {
          return state.copyWith(
            comingSoonList: state.comingSoonList,
            everyOneIsWatchingList: response.results,
            isLoading: false,
            isError: false,
          );
        },
      );
      // send to ui
      emit(newState);
    });
  }
}
