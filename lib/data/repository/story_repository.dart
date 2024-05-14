import 'dart:developer';

import 'package:ig_story/data/api/story_api.dart';
import 'package:ig_story/data/model/user_model.dart';

class StoryRepository {

  StoryRepository._();

  static final StoryRepository _instance = StoryRepository._();

  factory StoryRepository() {
    return _instance;
  }

  final StoryApi _storyApi = StoryApi();

  Future<List<UserModel>> fetchStories() async {
    try{
      final List response = await _storyApi.fetchStories();
      final List<UserModel> users = [];

      for(Map<String, dynamic> userData in response){
        users.add(UserModel.fromMap(userData));
      }

      return users;
    }
    catch(e,s){
      log(e.toString());
      log(s.toString());
      return [];
    }
  }

}