import 'dart:developer';

import 'package:get_it/get_it.dart';
import 'package:ig_story/logic/cubit/story_cubit/story_cubit.dart';

var serviceLocator = GetIt.I;

void setupServices() {
  try{
    serviceLocator.registerLazySingleton<StoryCubit>(() => StoryCubit());
  }
  catch(e,s){
    log(e.toString());
    log(s.toString());
  }
}