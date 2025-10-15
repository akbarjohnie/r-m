import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:rick_and_morty/core/core.dart';
import 'package:rick_and_morty/data/models/models.dart';

part 'characters.g.dart';

@RestApi(callAdapter: ErrorAdapter)
abstract class CharacterRemoteDatasourse {
  factory CharacterRemoteDatasourse(
    Dio dio, {
    String baseUrl,
  }) = _CharacterRemoteDatasourse;

  @GET('/api/character')
  Future<Pagination<CharacterModel>> getCharacters({
    @Query('page') int? page,
    @Query('name') String? name,
    @Query('status') CharacterStatus? status,
    @Query('species') String? species,
    @Query('type') String? type,
    @Query('gender') CharacterGender? gender,
  });

  @GET('/api/character/{id}')
  Future<CharacterModel> getCharacter(
    @Path() int id,
  );

  @GET('/api/character/{ids}')
  Future<List<CharacterModel>> getMultipleCharacters(
    @Path() String ids,
  );
}
