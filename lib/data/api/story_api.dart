import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';

import '../../logic/services/app_manager_service.dart';

class StoryApi {

  StoryApi._();

  static final StoryApi _instance = StoryApi._();

  factory StoryApi() {
    return _instance;
  }

  final FirebaseFirestore reference = FirebaseFirestore.instance;

  Future<List> fetchStories() async {
    try{
      var response = await reference.collection(AppManager().getUserCollection()).get();
      final List users = [];

      for(var doc in response.docs){
        Map<String, dynamic> storyData = {};

        var storyResponse = await reference.collection(AppManager().getUserCollection())
            .doc(doc.id).collection(AppManager().getStoryCollection()).get();

        storyData['name'] = doc.data()['name'];
        storyData['profile_pic'] = doc.data()['profile_pic'];
        storyData['stories'] = storyResponse.docs.map((e) => e.data()).toList();

        users.add(storyData);
      }
      return users;
    }
    catch(e, s){
      log(e.toString());
      log(s.toString());
      return [];
    }
  }

}