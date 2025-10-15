import 'package:rick_and_morty/data/data.dart';

abstract interface class ILocationsRepository {
  Future<List<LocationsModel>> loadLocationss();

}
