import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'fast_laugh_event.dart';
part 'fast_laugh_state.dart';
part 'fast_laugh_bloc.freezed.dart';

class FastLaughBloc extends Bloc<FastLaughEvent, FastLaughState> {
  FastLaughBloc() : super(_Initial()) {
    on<FastLaughEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
