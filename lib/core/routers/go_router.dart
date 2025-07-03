import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:deula/feautures/main/bottom_navi.dart';
import 'package:deula/feautures/home/presentation/screens/home_screen.dart';
import 'package:deula/feautures/add_meal/presentation/screens/add_screen.dart';

final GlobalKey<NavigatorState> _rootNavigatorKey = GlobalKey<NavigatorState>();
final GlobalKey<NavigatorState> _shellNavigatorKey =
    GlobalKey<NavigatorState>();

final GoRouter appRouter = GoRouter(
  navigatorKey: _rootNavigatorKey,
  initialLocation: '/home',
  routes: [
    ShellRoute(
      navigatorKey: _shellNavigatorKey,
      builder: (context, state, child) {
        return MainScreen();
      },
      routes: [
        GoRoute(
          path: '/home',
          name: 'home',
          pageBuilder: (context, state) =>
              const NoTransitionPage(child: HomeScreen()),
        ),
        GoRoute(
          path: '/add',
          name: 'add',
          pageBuilder: (context, state) => NoTransitionPage(
            child: AddMealScreen(
              onMealAdded: () {

                context.go('/home');
              },
            ),
          ),
        ),
        GoRoute(
          path: '/profile',
          name: 'profile',
          pageBuilder: (context, state) =>
              const NoTransitionPage(child: Center(child: Text("Profile"))),
        ),
      ],
    ),
  ],
);
