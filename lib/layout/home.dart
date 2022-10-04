import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:social_app/shared/components/components.dart';
import 'package:social_app/shared/components/cubit/cubit.dart';
import 'package:social_app/shared/components/cubit/states.dart';

import '../modules/new_post.dart';

class Home extends StatelessWidget{
  @override

  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit,SocialStates>(
      listener: (context,state){
        if(state is NewPostState){
          navigation(context, NewPostScreen());
        }
      },
      builder: (context,state){
        var cubit=SocialCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            title: (cubit.currentIndex==3 || cubit.currentIndex==4)? Text(cubit.titles[cubit.currentIndex-1]):Text(cubit.titles[cubit.currentIndex]),
            actions: [
              IconButton(
                  onPressed: (){},
                  icon: const Icon(
                      IconlyBroken.notification,
                     ),
              ),
              IconButton(
                  onPressed: (){},
                  icon: const Icon(
                    IconlyBroken.search,
                   ),
              ),
            ],
          ),
          body:(cubit.currentIndex==3 || cubit.currentIndex==4)? cubit.screens[(cubit.currentIndex)-1]:cubit.screens[cubit.currentIndex],
          bottomNavigationBar: BottomNavigationBar(
            onTap: (index){
              cubit.changeScreens(index);
            },
            currentIndex: cubit.currentIndex,
            items: const [
              BottomNavigationBarItem(
                icon: Icon(
                  IconlyBroken.home,
                ),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  IconlyBroken.chat,
                ),
                label: 'Chats'
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  IconlyBroken.paperUpload,
                ),
                label: 'Post',
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  IconlyBroken.location,
                ),
                label: 'Users'
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  IconlyBroken.setting,
                ),
                label: 'Setting'
              ),
            ],
          ),
        );
      },
    );
  }
}