import 'package:cinemapedia/domain/datasources/movies_datasource.dart';
import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:cinemapedia/domain/repositories/movies_repositories.dart';

class MovieRepositoryImpl extends MovieRepositories {
  final MovieDatasource movieDatasource;

  MovieRepositoryImpl({required this.movieDatasource});

  @override
  Future<List<Movie>> getNowPlaying({int page = 1}) async {
    return await movieDatasource.getNowPlaying(page: page);
  }

  @override
  Future<List<Movie>> getPopular({int page = 1}) async {
    return await movieDatasource.getPopular(page: page);
  }

  @override
  Future<List<Movie>> getTopRated({int page = 1}) async {
    return await movieDatasource.getTopRated(page: page);
  }

  @override
  Future<List<Movie>> getUpcoming({int page = 1}) async {
    return await movieDatasource.getUpcoming(page: page);
  }
}
