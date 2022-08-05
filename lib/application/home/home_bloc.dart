import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:netflix/domain/core/failures/main_failure.dart';
import 'package:netflix/domain/hot_and_new/hot_and_new_service.dart';
import 'package:netflix/domain/hot_and_new/model/hot_and_new_resp.dart';

part 'home_event.dart';
part 'home_state.dart';
part 'home_bloc.freezed.dart';

@injectable
class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final HotAndNewService _homeService;
  HomeBloc(this._homeService) : super(HomeState.initial()) {
    /*on event get homescreen data*/
    on<GetHomeScreenData>((event, emit) async {
      // send loading to ui
      emit(state.copyWith(
        isLoading: true,
        isError: false,
      ));

      // get data
      final _movieList = await _homeService.getHotAndNewMovieData();
      final _tvList = await _homeService.getHotAndNewTvData();

      // transform data

      final _state1 = _movieList.fold((MainFailure failure) {
        return state.copyWith(
          stateId: DateTime.now().microsecondsSinceEpoch.toString(),
          pastYearMovieList: [],
          trendingMovieList: [],
          tenseDramaMovieList: [],
          southIndianMovieList: [],
          trendingTvList: [],
          isLoading: false,
          isError: true,
        );
      }, (HotAndNewResp response) {
        final pastYear = response.results;
        final trendingMovie = response.results;
        final tenseDrama = response.results;
        final southIndian = response.results;
        pastYear.shuffle();
        trendingMovie.shuffle();
        tenseDrama.shuffle();
        southIndian.shuffle();

        return state.copyWith(
          stateId: DateTime.now().microsecondsSinceEpoch.toString(),
          pastYearMovieList: pastYear,
          trendingMovieList: trendingMovie,
          tenseDramaMovieList: tenseDrama,
          southIndianMovieList: southIndian,
          trendingTvList: state.trendingTvList,
          isLoading: false,
          isError: false,
        );
      });

      //send to UI
      emit(_state1);

      final _state2 = _tvList.fold((MainFailure failure) {
        return state.copyWith(
          stateId: DateTime.now().microsecondsSinceEpoch.toString(),
          pastYearMovieList: [],
          trendingMovieList: [],
          tenseDramaMovieList: [],
          southIndianMovieList: [],
          trendingTvList: [],
          isLoading: false,
          isError: true,
        );
      }, (HotAndNewResp response) {
        final trendingTv = response.results;
        trendingTv.shuffle();

        return state.copyWith(
          stateId: DateTime.now().microsecondsSinceEpoch.toString(),
          pastYearMovieList: state.pastYearMovieList,
          trendingMovieList: state.trendingMovieList,
          tenseDramaMovieList: state.tenseDramaMovieList,
          southIndianMovieList: state.southIndianMovieList,
          trendingTvList: trendingTv,
          isLoading: false,
          isError: false,
        );
      });

      // send to UI
      emit(_state2);
    });
  }
}
