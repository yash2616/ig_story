import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ig_story/data/repository/story_repository.dart';

import '../../../data/model/user_model.dart';

part 'story_state.dart';

class StoryCubit extends Cubit<StoryState> {
  StoryCubit() : super(const StoryInitialState());

  final StoryRepository _storyRepository = StoryRepository();

  List<UserModel> users = [];

  void fetchStories() async {
    emit(const StoryLoadingState());
    users = await _storyRepository.fetchStories();
    emit(StoryLoadedState(users: users));
  }

  void refreshStories() {
    emit(StoryLoadedState(
      users: users,
      buildNo: state is StoryLoadedState
          ? (state as StoryLoadedState).buildNo + 1
          : 0,
    ));
  }

}