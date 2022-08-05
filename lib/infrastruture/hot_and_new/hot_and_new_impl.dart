import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:netflix/domain/core/failures/main_failure.dart';
import 'package:dartz/dartz.dart';
import 'package:netflix/domain/hot_and_new/hot_and_new_service.dart';
import 'package:netflix/domain/hot_and_new/model/hot_and_new_resp.dart';

import '../../domain/core/api_end_points.dart';

@LazySingleton(as: HotAndNewService)
class HotAndNewImplimentation implements HotAndNewService {
  @override
  Future<Either<MainFailure, HotAndNewResp>> getHotAndNewMovieData() async {
    try {
      final Response respones =
          await Dio(BaseOptions()).get(ApiEndPoints.hotAndNewMovie);

      if (respones.statusCode == 200 || respones.statusCode == 201) {
        final searchResult = HotAndNewResp.fromJson(respones.data);

        return Right(searchResult);
      } else {
        return const Left(
          MainFailure.serverFailure(),
        );
      }
    } catch (e) {
      log(e.toString());
      return const Left(
        MainFailure.clientfailure(),
      );
    }
  }

  @override
  Future<Either<MainFailure, HotAndNewResp>> getHotAndNewTvData() async {
    try {
      final Response respones =
          await Dio(BaseOptions()).get(ApiEndPoints.hotAndNewTv);

      if (respones.statusCode == 200 || respones.statusCode == 201) {
        final searchResult = HotAndNewResp.fromJson(respones.data);

        return Right(searchResult);
      } else {
        return const Left(
          MainFailure.serverFailure(),
        );
      }
    } catch (e) {
      log(e.toString());
      return const Left(
        MainFailure.clientfailure(),
      );
    }
  }
}
