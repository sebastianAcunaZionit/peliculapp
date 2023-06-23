// la idea es que podamos crear una pelicula basado en un objeto a recibir
import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:cinemapedia/infrastructure/models/moviedb/movie_details.dart';
import 'package:cinemapedia/infrastructure/models/moviedb/movie_moviedb.dart';

class MovieMapper {
  static Movie movieDbToEntity(MovieMovieDB moviedb) => Movie(
      adult: moviedb.adult,
      backdropPath: moviedb.backdropPath != ''
          ? 'https://image.tmdb.org/t/p/w500/${moviedb.backdropPath}'
          : 'https://ih1.redbubble.net/image.1893341687.8294/poster,504x498,f8f8f8-pad,600x600,f8f8f8.jpg',
      genreIds: moviedb.genreIds.map((e) => e.toString()).toList(),
      id: moviedb.id,
      originalLanguage: moviedb.originalLanguage,
      originalTitle: moviedb.originalTitle,
      overview: moviedb.overview,
      popularity: moviedb.popularity,
      posterPath: moviedb.posterPath != ''
          ? 'https://image.tmdb.org/t/p/w500/${moviedb.posterPath}'
          : 'no-poster',
      releaseDate: moviedb.releaseDate,
      title: moviedb.title,
      video: moviedb.video,
      voteAverage: moviedb.voteAverage,
      voteCount: moviedb.voteCount);

  static Movie movieDetailToEntity(MovieDetails movieDetails) => Movie(
        adult: movieDetails.adult,
        backdropPath: movieDetails.backdropPath != ''
            ? 'https://image.tmdb.org/t/p/w500/${movieDetails.backdropPath}'
            : 'https://ih1.redbubble.net/image.1893341687.8294/poster,504x498,f8f8f8-pad,600x600,f8f8f8.jpg',
        genreIds: movieDetails.genres.map((e) => e.name).toList(),
        id: movieDetails.id,
        originalLanguage: movieDetails.originalLanguage,
        originalTitle: movieDetails.originalTitle,
        overview: movieDetails.overview,
        popularity: movieDetails.popularity,
        posterPath: movieDetails.posterPath != ''
            ? 'https://image.tmdb.org/t/p/w500/${movieDetails.posterPath}'
            : 'no-poster',
        releaseDate: movieDetails.releaseDate,
        title: movieDetails.title,
        video: movieDetails.video,
        voteAverage: movieDetails.voteAverage,
        voteCount: movieDetails.voteCount,
      );
}
