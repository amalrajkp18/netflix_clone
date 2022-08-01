import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:netflix/domain/core/api_end_points.dart';
import 'package:netflix/domain/core/failures/main_failure.dart';
import 'package:netflix/domain/search/models/search_resp.dart';
import 'package:dartz/dartz.dart';
import 'package:netflix/domain/search/search_service.dart';

@LazySingleton(as: SearchService)
class SearchImpl implements SearchService {
  @override
  Future<Either<MainFailure, SearchResp>> searchMovies(
      {required String movieQuery}) async {
    try {
      final Response respones = await Dio(BaseOptions()).get(
        ApiEndPoints.search,
        queryParameters: {'query': movieQuery},
      );

      if (respones.statusCode == 200 || respones.statusCode == 201) {
        final searchResult = SearchResp.fromJson(respones.data);

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
