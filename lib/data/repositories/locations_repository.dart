import 'package:rick_and_morty/data/models/locations/locations.dart';
import 'package:rick_and_morty/domain/domain.dart';

final class LocationsRepositoryImpl implements ILocationsRepository {
  const LocationsRepositoryImpl();

  @override
  Future<List<LocationsModel>> loadLocationss() {
    // TODO: implement loadLocationss
    throw UnimplementedError();
  }
}
