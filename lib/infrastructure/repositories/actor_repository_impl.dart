import 'package:cinemapedia/domain/datasources/actors_datasource.dart';
import 'package:cinemapedia/domain/entities/actor.dart';
import 'package:cinemapedia/domain/repositories/actors_repository.dart';

class ActorsRepositoryImpl implements ActorsRepository {
  final ActorsDatasource actorsDatasource;

  ActorsRepositoryImpl(this.actorsDatasource);

  @override
  Future<List<Actor>> getActorsByMovie(String movieId) async {
    return actorsDatasource.getActorsByMovie(movieId);
  }
}
