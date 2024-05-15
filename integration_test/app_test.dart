import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ig_story/core/service_locator.dart';
import 'package:ig_story/logic/services/app_manager_service.dart';
import 'package:ig_story/ui/custom_widgets/custom_close_button.dart';
import 'package:ig_story/ui/screens/home_screen/components/story_avatar.dart';
import 'package:ig_story/ui/screens/home_screen/home_screen.dart';
import 'package:ig_story/ui/screens/story_screen/story_screen.dart';
import 'package:integration_test/integration_test.dart';
import 'package:ig_story/main.dart' as app;

void main() async {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  WidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp();
  setupServices();
  AppManager().setUserCollection('stories');
  AppManager().setStoryCollection('story_list');

  group('Screen test', () {
    testWidgets(
      'home screen redirection',
      (tester) async {
        await tester.pumpWidget(const app.MyApp());
        await tester.pumpAndSettle(const Duration(seconds: 3));
        expect(find.byType(HomeScreen), findsOneWidget);
      },
    );

    testWidgets(
      'story screen redirection',
      (tester) async {
        await tester.pumpWidget(const app.MyApp());
        await tester.pumpAndSettle(const Duration(seconds: 3));
        await tester.tap(find.byType(StoryAvatar).at(1));
        await tester.pump(const Duration(seconds: 1));
        expect(find.byType(StoryScreen), findsOneWidget);
      },
    );
  });

  group('Button test', () {
    testWidgets(
      'story force close',
      (tester) async {
        await tester.pumpWidget(const app.MyApp());
        await tester.pumpAndSettle(const Duration(seconds: 3));
        await tester.tap(find.byType(StoryAvatar).at(1));
        await tester.pump(const Duration(seconds: 1));
        await tester.tap(find.byType(CustomCloseButton));
        await tester.pumpAndSettle();
        expect(find.byType(HomeScreen), findsOneWidget);
      },
    );
  });

  group('Story functionality test', () {
    testWidgets(
      'story auto close',
          (tester) async {
        await tester.pumpWidget(const app.MyApp());
        await tester.pumpAndSettle(const Duration(seconds: 3));
        await tester.tap(find.byType(StoryAvatar).at(1));
        await tester.pumpAndSettle();
        expect(find.byType(HomeScreen), findsOneWidget);
      },
    );
  });
}