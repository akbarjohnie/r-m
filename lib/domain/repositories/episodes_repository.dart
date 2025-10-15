import 'package:rick_and_morty/data/data.dart';

abstract interface class IEpisodesRepository {
  Future<List<EpisodesModel>> loadEpisodes();
}
