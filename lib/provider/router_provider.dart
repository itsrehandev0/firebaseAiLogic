import 'package:firebase_ai_logic/screens/featueres/AiStory/generate_ai_story.dart';
import 'package:firebase_ai_logic/screens/featueres/generate_food_screen.dart';
import 'package:firebase_ai_logic/screens/home/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

final routerProvider = Provider((ref) {
  return RouterProvider(ref);
});

class RouterProvider {
  final navigatorkey = GlobalKey<NavigatorState>();
  late GoRouter router;
  final Ref ref;
  RouterProvider(this.ref) {
    router = GoRouter(
      initialLocation: HomeScreen.routeLocation,
      navigatorKey: navigatorkey,
      debugLogDiagnostics: true,
      routes: [
        GoRoute(
          name: HomeScreen.routeName,
          path: HomeScreen.routeLocation,
          builder: (context, state) => HomeScreen(),
        ),
        GoRoute(
          name: GenerateFoodScreen.routeName,
          path: GenerateFoodScreen.routeLocation,
          builder: (context, state) => GenerateFoodScreen(),
        ),
        GoRoute(
          name: GenerateAiStory.routeName,
          path: GenerateAiStory.routeLocation,
          builder: (context, state) => GenerateAiStory(),
        ),
      ],
    );
  }
}
