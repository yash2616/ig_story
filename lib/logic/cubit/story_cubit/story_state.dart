part of 'story_cubit.dart';

abstract class StoryState extends Equatable {
  const StoryState();
}

class StoryInitialState extends StoryState {
  const StoryInitialState();

  @override
  List<Object?> get props => [];
}

class StoryLoadingState extends StoryState {
  const StoryLoadingState();

  @override
  List<Object?> get props => [];
}

class StoryLoadedState extends StoryState {

  final int buildNo;
  final List<UserModel> users;

  const StoryLoadedState({required this.users, this.buildNo = 0});

  @override
  List<Object?> get props => [buildNo];
}

class StoryErrorState extends StoryState {
  const StoryErrorState();

  @override
  List<Object?> get props => [];
}