import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:rick_and_morty/core/core.dart';
import 'package:rick_and_morty/data/data.dart';

part 'locations.g.dart';

@RestApi(callAdapter: ErrorAdapter)
abstract class LocationsRemoteDatasourse {
  factory LocationsRemoteDatasourse(
    Dio dio, {
    String baseUrl,
  }) = _LocationsRemoteDatasourse;

  @GET(LocationEndpoints.getListLocations)
  Future<Pagination<LocationsModel>> getLocations({
    @Query('page') int? page,
    @Query('name') String? name,
    @Query('type') String? type,
    @Query('dimension') String? dimension,
  });

  @GET(LocationEndpoints.getLocation)
  Future<LocationsModel> getLocation(
    @Path() int id,
  );

  @GET(LocationEndpoints.getSomeLocations)
  Future<List<LocationsModel>> getMultipleLocation(
    @Path() String ids,
  );
}
