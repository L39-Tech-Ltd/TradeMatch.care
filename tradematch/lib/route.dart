import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'screen/screens.dart' as screens;

final GoRouter router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      pageBuilder:
          (context, state) =>
              _smoothPageTransition(context, state, screens.HomePage()),
    ),
    GoRoute(
      path: '/home',
      pageBuilder:
          (context, state) =>
              _smoothPageTransition(context, state, screens.HomePage()),
    ),
    GoRoute(
      path: '/test',
      pageBuilder:
          (context, state) =>
              _smoothPageTransition(context, state, screens.TestPage()),
    ),
  ],
);

CustomTransitionPage _smoothPageTransition(
  BuildContext context,
  GoRouterState state,
  Widget child,
) {
  return CustomTransitionPage(
    key: state.pageKey,
    child: child,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      // Change the opacity of the screen using a Curve based on the the animation's
      // value
      return FadeTransition(
        opacity: CurveTween(
          curve: Curves.fastEaseInToSlowEaseOut,
        ).animate(animation),
        child: child,
      );
    },
    transitionDuration: const Duration(seconds: 1),
  );
}
