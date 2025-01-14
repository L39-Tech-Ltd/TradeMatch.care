import 'package:go_router/go_router.dart';
import 'screen/screens.dart' as screens;

final GoRouter router = GoRouter(
  routes: [
    GoRoute(path: '/', builder: (context, state) => screens.HomePage()),
    GoRoute(path: '/home', builder: (context, state) => screens.HomePage()),
  ],
);
