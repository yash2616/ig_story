import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ig_story/data/repository/story_repository.dart';

import '../../../data/model/user_model.dart';

part 'story_state.dart';

class StoryCubit extends Cubit<StoryState> {
  StoryCubit() : super(const StoryInitialState());

  final StoryRepository _storyRepository = StoryRepository();

  List<UserModel> _users = [];

  void fetchStories() async {
    emit(const StoryLoadingState());
    _users = await _storyRepository.fetchStories();
    emit(StoryLoadedState(users: _users));
  }

  void refreshStories() {
    emit(StoryLoadedState(
      users: _users,
      buildNo: state is StoryLoadedState
          ? (state as StoryLoadedState).buildNo + 1
          : 0,
    ));
  }

}