import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:netflix/domain/core/api_end_points.dart';
import 'package:dartz/dartz.dart';
import 'package:netflix/domain/core/failures/main_failure.dart';
import 'package:netflix/domain/downloads/download_service.dart';
import 'package:netflix/domain/downloads/models/downloads.dart';

@LazySingleton(as: DownloadService)
class DownloadsRepository implements DownloadService {
  @override
  Future<Either<MainFailure, List<Downloads>>> getDownloadsImages() async {
    try {
      final Response respones =
          await Dio(BaseOptions()).get(ApiEndPoints.downloads);
      if (respones.statusCode == 200 || respones.statusCode == 201) {
        final downloadsList = (respones.data['results'] as List).map((e) {
          return Downloads.fromJson(e);
        }).toList();

        return Right(downloadsList);
      } else {
        return const Left(MainFailure.serverFailure());
      }
    } catch (e) {
      return const Left(MainFailure.clientfailure());
    }
  }
}
