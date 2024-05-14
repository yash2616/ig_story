// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:ig_story/data/model/story_model.dart';

class UserModel {

  String userName;
  String profilePic;
  List<StoryModel> stories;
  UserModel({
    required this.userName,
    required this.profilePic,
    required this.stories,
  });


  UserModel copyWith({
    String? userName,
    String? profilePic,
    List<StoryModel>? stories,
  }) {
    return UserModel(
      userName: userName ?? this.userName,
      profilePic: profilePic ?? this.profilePic,
      stories: stories ?? this.stories,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'userName': userName,
      'profilePic': profilePic,
      'stories': stories.map((x) => x.toMap()).toList(),
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      userName: (map['userName'] ?? map['name'] ?? '') as String,
      profilePic: (map['profilePic'] ?? map['profile_pic']) as String,
      stories: List<StoryModel>.from((map['stories'] as List).map<StoryModel>((x) => StoryModel.fromMap(x as Map<String,dynamic>),),),
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) => UserModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'UserModel(userName: $userName, profilePic: $profilePic, stories: $stories)';

  @override
  bool operator ==(covariant UserModel other) {
    if (identical(this, other)) return true;
  
    return 
      other.userName == userName &&
      other.profilePic == profilePic &&
      listEquals(other.stories, stories);
  }

  @override
  int get hashCode => userName.hashCode ^ profilePic.hashCode ^ stories.hashCode;
}
