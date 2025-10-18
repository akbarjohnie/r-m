import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:rick_and_morty/core/core.dart';
import 'package:rick_and_morty/data/data.dart';

part 'episodes.g.dart';

@RestApi(callAdapter: ErrorAdapter)
abstract class EpisodesRemoteDatasourse {
  factory EpisodesRemoteDatasourse(
    Dio dio, {
    String baseUrl,
  }) = _EpisodesRemoteDatasourse;

  @GET(EpisodesEndpoints.getListEpisodes)
  Future<Pagination<EpisodesModel>> getEpisodes({
    @Query('page') int? page,
    @Query('name') String? name,
    @Query('episode') String? episode,
  });

  @GET(EpisodesEndpoints.getEpisode)
  Future<EpisodesModel> getEpisode(
    @Path() int id,
  );

  @GET(EpisodesEndpoints.getSomeEpisodes)
  Future<List<EpisodesModel>> getMultipleEpisode(
    @Path() String ids,
  );
}
