import 'package:animate_do/animate_do.dart';
import 'package:cinemapedia/domain/entities/actor.dart';
import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:cinemapedia/presentation/providers/movies/movie_info_provider.dart';
import 'package:cinemapedia/presentation/providers/providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MovieScreen extends ConsumerStatefulWidget {
  static const String name = 'movie-screen';

  const MovieScreen({super.key, required this.movieId});

  final String movieId;

  @override
  MovieScreenState createState() => MovieScreenState();
}

class MovieScreenState extends ConsumerState<MovieScreen> {
  @override
  void initState() {
    super.initState();

    ref.read(movieInfoProvider.notifier).loadMovie(widget.movieId);
    ref.read(actorsProvider.notifier).loadActors(widget.movieId);
  }

  @override
  Widget build(BuildContext context) {
    final Movie? movie = ref.watch(movieInfoProvider)[widget.movieId];

    if (movie == null) {
      return const Scaffold(
          body: Center(child: CircularProgressIndicator(strokeWidth: 2)));
    }

    return Scaffold(
      body: CustomScrollView(physics: const ClampingScrollPhysics(), slivers: [
        _CustomSliverAppBar(movie: movie),
        SliverList(
            delegate: SliverChildBuilderDelegate(
          childCount: 1,
          (context, index) => _MovieDetails(movie: movie),
        ))
      ]),
      bottomNavigationBar: null,
    );
  }
}

class _MovieDetails extends StatelessWidget {
  const _MovieDetails({required this.movie});

  final Movie movie;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final textStyles = Theme.of(context).textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.network(
                  movie.posterPath,
                  width: size.width * 0.3,
                ),
              ),
              const SizedBox(width: 10),
              SizedBox(
                width: (size.width - 40) * 0.7,
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(movie.title, style: textStyles.titleLarge),
                      const SizedBox(height: 10),
                      Text(movie.overview)
                    ]),
              )
            ],
          ),
        ),
        Padding(
            padding: const EdgeInsets.all(8),
            child: Wrap(children: [
              ...movie.genreIds.map(
                (gender) => Container(
                  margin: const EdgeInsets.only(right: 10),
                  child: Chip(
                    label: Text(gender),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                  ),
                ),
              )
            ])),
        // Padding(
        //   padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
        //   child: Text("Reparto", style: textStyles.titleLarge),
        // ),
        _ActorsByMovie(movieId: movie.id.toString(), textStyles: textStyles),
        const SizedBox(height: 50),
      ],
    );
  }
}

class _ActorsByMovie extends ConsumerWidget {
  const _ActorsByMovie({
    required this.movieId,
    required this.textStyles,
  });

  final String movieId;
  final TextTheme textStyles;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final actorsByMovie = ref.watch(actorsProvider);

    if (actorsByMovie[movieId] == null) {
      return const Center(
        child: CircularProgressIndicator(strokeWidth: 4),
      );
    }

    final actors = actorsByMovie[movieId]!;

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
        height: 300,
        child: ListView.builder(
            itemCount: actors.length,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              final Actor actor = actors[index];
              return FadeInRight(
                  child: _ActorCard(actor: actor, textStyles: textStyles));
            }),
      ),
    );
  }
}

class _ActorCard extends StatelessWidget {
  const _ActorCard({
    required this.actor,
    required this.textStyles,
  });

  final Actor actor;
  final TextTheme textStyles;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 135,
      margin: const EdgeInsets.only(right: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Image.network(
              actor.profilePath,
              fit: BoxFit.cover,
              height: 180,
              width: 135,
            ),
          ),
          const SizedBox(height: 5),
          Text(actor.name, style: textStyles.labelMedium, maxLines: 2),
          Text(
            actor.character ?? '',
            style: const TextStyle(
                fontWeight: FontWeight.bold, overflow: TextOverflow.ellipsis),
            maxLines: 3,
          )
        ],
      ),
    );
  }
}

class _CustomSliverAppBar extends StatelessWidget {
  const _CustomSliverAppBar({super.key, required this.movie});

  final Movie movie;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SliverAppBar(
      actions: [
        IconButton(
          onPressed: () {},
          icon: const Icon(Icons.favorite_border_outlined),
          // icon: const Icon(Icons.favorite_rounded, color: Colors.red),
        )
      ],
      backgroundColor: Colors.black,
      expandedHeight: size.height * 0.7,
      foregroundColor: Colors.white,
      flexibleSpace: FlexibleSpaceBar(
        titlePadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        title: Text(
          movie.title,
          style: const TextStyle(fontSize: 20),
          textAlign: TextAlign.start,
        ),
        background: Stack(children: [
          SizedBox.expand(
            child: Image.network(
              movie.posterPath,
              fit: BoxFit.cover,
            ),
          ),
          const _PosterGradient(
            stops: [0.1, 0.4],
            end: Alignment.center,
            begin: Alignment.topRight,
            colors: [Colors.black87, Colors.transparent],
          ),
          const _PosterGradient(
            stops: [0.1, 0.4],
            begin: Alignment.topLeft,
            colors: [Colors.black87, Colors.transparent],
          ),
          const _PosterGradient(
            stops: [0.7, 1.0],
            begin: Alignment.center,
            colors: [
              Colors.transparent,
              Colors.black87,
            ],
          )
        ]),
      ),
    );
  }
}

class _PosterGradient extends StatelessWidget {
  final AlignmentGeometry begin;
  final AlignmentGeometry? end;
  final List<double> stops;
  final List<Color> colors;
  const _PosterGradient(
      {required this.begin,
      required this.stops,
      this.end,
      required this.colors});

  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
      child: DecoratedBox(
          decoration: BoxDecoration(
        gradient: LinearGradient(
            begin: begin,
            end: (end == null) ? Alignment.bottomCenter : end!,
            stops: stops,
            colors: colors),
      )),
    );
  }
}
