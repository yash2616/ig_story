// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class StoryModel {

  String mediaUrl;
  bool seen;
  StoryModel({
    required this.mediaUrl,
    required this.seen,
  });


  StoryModel copyWith({
    String? mediaUrl,
    bool? seen,
  }) {
    return StoryModel(
      mediaUrl: mediaUrl ?? this.mediaUrl,
      seen: seen ?? this.seen,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'mediaUrl': mediaUrl,
      'seen': seen,
    };
  }

  factory StoryModel.fromMap(Map<String, dynamic> map) {
    return StoryModel(
      mediaUrl: (map['mediaUrl'] ?? map['media_url']) as String,
      seen: map['seen'] as bool,
    );
  }

  String toJson() => json.encode(toMap());

  factory StoryModel.fromJson(String source) => StoryModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'StoryModel(mediaUrl: $mediaUrl, seen: $seen)';

  @override
  bool operator ==(covariant StoryModel other) {
    if (identical(this, other)) return true;
  
    return 
      other.mediaUrl == mediaUrl &&
      other.seen == seen;
  }

  @override
  int get hashCode => mediaUrl.hashCode ^ seen.hashCode;
}
