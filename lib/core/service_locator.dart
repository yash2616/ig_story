import 'package:get_it/get_it.dart';
import 'package:ig_story/logic/cubit/story_cubit/story_cubit.dart';

var serviceLocator = GetIt.I;

void setupServices() {
  serviceLocator.registerLazySingleton<StoryCubit>(() => StoryCubit());
}