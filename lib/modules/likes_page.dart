import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/shared/components/components.dart';

import '../models/users_model.dart';
import '../shared/components/cubit/cubit.dart';
import '../shared/components/cubit/states.dart';

class LikesPage extends StatelessWidget
{
  int num;
  LikesPage({Key? key,required this.num}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit,SocialStates>(
      listener: (BuildContext context, state) {  },
      builder: (BuildContext context, Object? state) {
        return Scaffold(
          appBar: appBar(context: context,title: 'Likes'),
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Expanded(
                  child: ListView.separated(
                    itemBuilder: (context,index){
                      return buildComment(context,SocialCubit.get(context).likesList[num][index]);
                    },
                    separatorBuilder: (context,index)=>const SizedBox(height: 15.0,),
                    itemCount:SocialCubit.get(context).likesList[num].length,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget buildComment(context,Users user)=>Container(
    child:Row(
      children: [
        CircleAvatar(
          backgroundImage: NetworkImage('${user.image}'),
          radius: 25.0,
        ),
        const SizedBox(
          width: 15.0,
        ),
        Expanded(
          child: Text(
            '${user.name}',
            style: const TextStyle(
              fontWeight:FontWeight.w800,
              fontSize: 16.0,
              height: 1.4,
            ),
          ),
        ),
      ],
    ),
  );

}