// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

import '../../../application/downloads/downloads_bloc.dart' as _i5;
import '../../../application/search/search_bloc.dart' as _i8;
import '../../../infrastruture/downloads/downloads_impl.dart' as _i4;
import '../../../infrastruture/search/saerch_impl.dart' as _i7;
import '../../downloads/download_service.dart' as _i3;
import '../../search/search_service.dart'
    as _i6; // ignore_for_file: unnecessary_lambdas

// ignore_for_file: lines_longer_than_80_chars
/// initializes the registration of provided dependencies inside of [GetIt]
_i1.GetIt $initGetIt(_i1.GetIt get,
    {String? environment, _i2.EnvironmentFilter? environmentFilter}) {
  final gh = _i2.GetItHelper(get, environment, environmentFilter);
  gh.lazySingleton<_i3.DownloadService>(() => _i4.DownloadsRepository());
  gh.factory<_i5.DownloadsBloc>(
      () => _i5.DownloadsBloc(get<_i3.DownloadService>()));
  gh.lazySingleton<_i6.SearchService>(() => _i7.SearchImpl());
  gh.factory<_i8.SearchBloc>(() =>
      _i8.SearchBloc(get<_i6.SearchService>(), get<_i3.DownloadService>()));
  return get;
}
