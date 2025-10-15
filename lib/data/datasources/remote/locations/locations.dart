import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:rick_and_morty/core/core.dart';
import 'package:rick_and_morty/data/models/models.dart';

part 'locations.g.dart';

@RestApi(callAdapter: ErrorAdapter)
abstract class LocationsRemoteDatasourse {
  factory LocationsRemoteDatasourse(
    Dio dio, {
    String baseUrl,
  }) = _LocationsRemoteDatasourse;

  @GET('/api/location')
  Future<Pagination<LocationsModel>> getLocations({
    @Query('page') int? page,
    @Query('name') String? name,
    @Query('type') String? type,
    @Query('dimension') String? dimension,
  });

  @GET('/api/location/{id}')
  Future<LocationsModel> getLocation(
    @Path() int id,
  );

  @GET('/api/location/{id}')
  Future<List<LocationsModel>> getMultipleLocation(
    @Path() String ids,
  );
}