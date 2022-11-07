import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/models/post_model.dart';
import 'package:social_app/shared/components/components.dart';

import '../shared/components/cubit/cubit.dart';
import '../shared/components/cubit/states.dart';

class LikesPage extends StatelessWidget
{
  List<LikeModel> list;
  LikesPage({Key? key,required this.list}) : super(key: key);

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
                      return buildLike(context,list[index]);
                    },
                    separatorBuilder: (context,index)=>const SizedBox(height: 15.0,),
                    itemCount:list.length,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget buildLike(context,LikeModel model)=>Container(
    child:Row(
      children: [
        CircleAvatar(
          backgroundImage: NetworkImage('${model.image}'),
          radius: 25.0,
        ),
        const SizedBox(
          width: 15.0,
        ),
        Expanded(
          child: Text(
            '${model.name}',
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