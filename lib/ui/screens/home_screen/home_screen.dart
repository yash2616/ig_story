import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ig_story/core/service_locator.dart';
import 'package:ig_story/logic/cubit/story_cubit/story_cubit.dart';
import 'package:ig_story/utilities/media_query.dart';

import 'components/home_header.dart';
import 'components/story_avatar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  @override
  void initState() {
    super.initState();
    serviceLocator<StoryCubit>().fetchStories();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const HomeHeader(),
          const SizedBox(height: 12,),
          AnimatedSize(
            duration: const Duration(milliseconds: 250),
            child: BlocBuilder<StoryCubit, StoryState>(
              builder: (context, state) {
                if(state is StoryInitialState || state is StoryLoadingState){
                  return const SizedBox();
                }
                else if(state is StoryLoadedState){
                  return SizedBox(
                    height: 104,
                    width: displayWidth(context),
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      shrinkWrap: true,
                      itemCount: state.users.length + 1,
                      itemBuilder: (context, index){
                        return StoryAvatar(
                          myAvatar: index == 0,
                          userData: index > 0 ? state.users[index - 1] : null,
                        );
                      },
                    ),
                  );
                }
                else{
                  return const Center(
                    child: Text(
                      'Error occurred',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  );
                }
              }
            ),
          ),
        ],
      ),
    );
  }
}
