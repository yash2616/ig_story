import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ig_story/data/repository/story_repository.dart';
import 'package:ig_story/logic/services/db_service.dart';

import '../../../data/model/user_model.dart';

part 'story_state.dart';

class StoryCubit extends Cubit<StoryState> {
  StoryCubit() : super(const StoryInitialState());

  final StoryRepository _storyRepository = StoryRepository();
  final DatabaseService _dbHelper = DatabaseService();

  List<UserModel> users = [];

  Future fetchStories() async {
    emit(const StoryLoadingState());
    users = await _storyRepository.fetchStories();
    _dbHelper.cacheMultipleStories(users);
    emit(StoryLoadedState(users: users));
  }

  void refreshStories({List<UserModel>? cachedData}) {
    if(cachedData != null){
      users = cachedData;
    }

    emit(StoryLoadedState(
      users: users,
      buildNo: state is StoryLoadedState
          ? (state as StoryLoadedState).buildNo + 1
          : 0,
    ));
  }

}