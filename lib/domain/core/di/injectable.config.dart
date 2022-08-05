// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

import '../../../application/downloads/downloads_bloc.dart' as _i5;
import '../../../application/fast_laugh/fast_laugh_bloc.dart' as _i6;
import '../../../application/home/home_bloc.dart' as _i11;
import '../../../application/hot_and_new/hot_and_new_bloc.dart' as _i12;
import '../../../application/search/search_bloc.dart' as _i13;
import '../../../infrastruture/downloads/downloads_impl.dart' as _i4;
import '../../../infrastruture/hot_and_new/hot_and_new_impl.dart' as _i8;
import '../../../infrastruture/search/saerch_impl.dart' as _i10;
import '../../downloads/download_service.dart' as _i3;
import '../../hot_and_new/hot_and_new_service.dart' as _i7;
import '../../search/search_service.dart'
    as _i9; // ignore_for_file: unnecessary_lambdas

// ignore_for_file: lines_longer_than_80_chars
/// initializes the registration of provided dependencies inside of [GetIt]
_i1.GetIt $initGetIt(_i1.GetIt get,
    {String? environment, _i2.EnvironmentFilter? environmentFilter}) {
  final gh = _i2.GetItHelper(get, environment, environmentFilter);
  gh.lazySingleton<_i3.DownloadService>(() => _i4.DownloadsRepository());
  gh.factory<_i5.DownloadsBloc>(
      () => _i5.DownloadsBloc(get<_i3.DownloadService>()));
  gh.factory<_i6.FastLaughBloc>(
      () => _i6.FastLaughBloc(get<_i3.DownloadService>()));
  gh.lazySingleton<_i7.HotAndNewService>(() => _i8.HotAndNewImplimentation());
  gh.lazySingleton<_i9.SearchService>(() => _i10.SearchImpl());
  gh.factory<_i11.HomeBloc>(() => _i11.HomeBloc(get<_i7.HotAndNewService>()));
  gh.factory<_i12.HotAndNewBloc>(
      () => _i12.HotAndNewBloc(get<_i7.HotAndNewService>()));
  gh.factory<_i13.SearchBloc>(() =>
      _i13.SearchBloc(get<_i9.SearchService>(), get<_i3.DownloadService>()));
  return get;
}
