import 'package:cinemapedia/presentation/screens/screens.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../presentation/views/views.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>();
final _shellNavigatorKeyA = GlobalKey<NavigatorState>(debugLabel: 'shellA');
final _shellNavigatorKeyB = GlobalKey<NavigatorState>(debugLabel: 'shellA');

final appRouter = GoRouter(
  initialLocation: '/',
  navigatorKey: _rootNavigatorKey,
  routes: [
    StatefulShellRoute.indexedStack(
        builder: (_, __, navigationShell) =>
            HomeScreen(childView: navigationShell),
        branches: <StatefulShellBranch>[
          StatefulShellBranch(navigatorKey: _shellNavigatorKeyA, routes: [
            GoRoute(
                parentNavigatorKey: _shellNavigatorKeyA,
                path: '/',
                builder: (context, state) => const HomeView(),
                routes: [
                  GoRoute(
                    path: 'movie/:id',
                    name: MovieScreen.name,
                    parentNavigatorKey: _rootNavigatorKey,
                    builder: (context, state) {
                      final movieId = state.pathParameters['id'] ?? 'no-id';
                      return MovieScreen(movieId: movieId);
                    },
                  )
                ]),
          ]),
          StatefulShellBranch(navigatorKey: _shellNavigatorKeyB, routes: [
            GoRoute(
              path: '/favorites',
              builder: (context, state) {
                return const FavoritesView();
              },
            )
          ])
        ]),

    // rutas padre / hijo
    // GoRoute(
    //     path: '/',
    //     name: HomeScreen.name,
    //     builder: (context, state) => const HomeScreen(
    //           childView: HomeView(),
    //         ),
    //     routes: [
    //       GoRoute(
    //         path: 'movie/:id',
    //         name: MovieScreen.name,
    //         builder: (context, state) {
    //           final movieId = state.pathParameters['id'] ?? 'no-id';
    //           return MovieScreen(movieId: movieId);
    //         },
    //       )
    //     ]),
  ],
);
