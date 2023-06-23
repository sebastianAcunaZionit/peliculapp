import 'package:cinemapedia/domain/entities/actor.dart';
import 'package:cinemapedia/presentation/providers/providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final actorsProvider =
    StateNotifierProvider<ActorMapNotifier, Map<String, List<Actor>>>((ref) {
  final fetchMovieInfo = ref.watch(actorsRepositoryProvider).getActorsByMovie;
  return ActorMapNotifier(getActors: fetchMovieInfo);
});

typedef GetMovieCallback = Future<List<Actor>> Function(String movieId);

class ActorMapNotifier extends StateNotifier<Map<String, List<Actor>>> {
  ActorMapNotifier({required this.getActors}) : super({});

  final GetMovieCallback getActors;

  Future<void> loadActors(String movieId) async {
    if (state[movieId] != null) return;

    final actors = await getActors(movieId);
    state = {...state, movieId: actors};
  }
}
