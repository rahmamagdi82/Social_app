import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/models/users_model.dart';
import 'package:social_app/modules/chat_details.dart';
import 'package:social_app/shared/components/components.dart';
import 'package:social_app/shared/components/cubit/cubit.dart';
import 'package:social_app/shared/components/cubit/states.dart';

class ChatsScreen extends StatelessWidget
{
  const ChatsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit,SocialStates>(
        builder: (context,state)=>ConditionalBuilder(
          condition: SocialCubit.get(context).chats.length > 0,
          builder: (BuildContext context) {
            return ListView.separated(
              physics: const BouncingScrollPhysics(),
              itemBuilder: (context,index)=>buildChat(SocialCubit.get(context).chats[index],context),
              separatorBuilder: (context,index)=>myDivider(),
              itemCount: SocialCubit.get(context).chats.length,
            );
          },
         fallback: (context)=>const Center(child: Text('You don\'t have any chats yet' )),
        ),
        listener: (context,state){}
    );
  }

  Widget buildChat(Users model,context)=>Padding(
    padding: const EdgeInsets.all(20.0),
    child: InkWell(
      onTap: (){
        navigation(context, ChatDetails(
          model:model,
        ));
      },
      child: Row(
        children: [
          CircleAvatar(
            backgroundImage: NetworkImage('${model.image}'),
            radius: 25.0,
          ),
          const SizedBox(
            width: 15.0,
          ),
          Text(
            '${model.name}',
            style: const TextStyle(
              height: 1.4,
            ),
          ),
        ],
      ),
    ),
  );

}