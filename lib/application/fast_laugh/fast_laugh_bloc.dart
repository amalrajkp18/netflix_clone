import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:netflix/domain/core/failures/main_failure.dart';
import 'package:netflix/domain/downloads/download_service.dart';
import 'package:netflix/domain/downloads/models/downloads.dart';

part 'fast_laugh_event.dart';
part 'fast_laugh_state.dart';
part 'fast_laugh_bloc.freezed.dart';

final dummyVideoUrls = [
  'https://assets.mixkit.co/videos/preview/mixkit-excited-girl-with-a-stuffed-santa-claus-39747-large.mp4',
  "https://assets.mixkit.co/videos/preview/mixkit-portrait-of-a-woman-in-a-pool-1259-large.mp4",
  'https://assets.mixkit.co/videos/preview/mixkit-white-flowers-in-the-breeze-1187-large.mp4',
  "https://assets.mixkit.co/videos/preview/mixkit-mysterious-pale-looking-fashion-woman-at-winter-39878-large.mp4",
  "https://assets.mixkit.co/videos/preview/mixkit-girl-in-neon-sign-1232-large.mp4"
      "https://assets.mixkit.co/videos/preview/mixkit-man-dancing-under-changing-lights-1240-large.mp4",
  "https://assets.mixkit.co/videos/preview/mixkit-man-holding-neon-light-1238-large.mp4",
  "https://assets.mixkit.co/videos/preview/mixkit-man-under-multicolored-lights-1237-large.mp4",
  'https://assets.mixkit.co/videos/preview/mixkit-tree-with-yellow-flowers-1173-large.mp4',
  'https://assets.mixkit.co/videos/preview/mixkit-man-under-colored-lights-1241-large.mp4',
  'https://assets.mixkit.co/videos/preview/mixkit-red-frog-on-a-log-1487-large.mp4',
  'https://assets.mixkit.co/videos/preview/mixkit-mother-with-her-little-daughter-eating-a-marshmallow-in-nature-39764-large.mp4',
  'https://assets.mixkit.co/videos/preview/mixkit-woman-running-above-the-camera-on-a-running-track-32807-large.mp4'
];

@injectable
class FastLaughBloc extends Bloc<FastLaughEvent, FastLaughState> {
  final DownloadService _downloadService;
  FastLaughBloc(this._downloadService) : super(FastLaughState.initial()) {
    on<Initialize>((event, emit) async {
      //sending loading to ui

      emit(state.copyWith(
        videoList: [],
        isLoading: true,
        isError: false,
      ));

      //get trending movies
      final result = await _downloadService.getDownloadsImages();
      final data = result.fold((MainFailure failure) {
        return state.copyWith(
          videoList: [],
          isLoading: false,
          isError: true,
        );
      }, (List<Downloads> download) {
        return state.copyWith(
          videoList: download,
          isLoading: false,
          isError: false,
        );
      });
      // send to ui
      emit(data);
    });
  }
}
