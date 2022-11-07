import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:social_app/models/post_model.dart';
import 'package:social_app/shared/components/components.dart';

import '../shared/components/cubit/cubit.dart';
import '../shared/components/cubit/states.dart';
import '../shared/styles/colors.dart';

class CommentPage extends StatelessWidget
{
  var commentController=TextEditingController();
  String postId;
  List<CommentModel> list;

  CommentPage({Key? key,required this.postId,required this.list}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit,SocialStates>(
      listener: (BuildContext context, state) {  },
      builder: (BuildContext context, Object? state) {
        return Scaffold(
          appBar: appBar(context: context,title: 'Comments'),
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Expanded(
                  child: ListView.separated(
                    itemBuilder: (context,index){
                      return buildComment(context,list[index]);
                    },
                    separatorBuilder: (context,index)=>const SizedBox(height: 15.0,),
                    itemCount:list.length,
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        style: const TextStyle(color: Colors.black),
                        keyboardType: TextInputType.text,
                        controller: commentController,
                        decoration: const InputDecoration(
                          hintText: 'Enter your comment ... ',
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    MaterialButton(
                      onPressed: (){
                        if(commentController.text.isNotEmpty) {
                          SocialCubit.get(context).commentPost(postId, list,commentController.text);
                        }
                        commentController.text='';
                      },
                      minWidth: 1.0,
                      child: const Icon(
                        IconlyBroken.send,
                        size: 25.0,
                        color: defultColor,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget buildComment(context,CommentModel comment)=>Container(
    child:Row(
      children: [
        CircleAvatar(
          backgroundImage: NetworkImage('${comment.image}'),
          radius: 25.0,
        ),
        const SizedBox(
          width: 15.0,
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '${comment.name}',
                style: const TextStyle(
                  fontWeight:FontWeight.w800,
                  fontSize: 16.0,
                  height: 1.4,
                ),
              ),
              Text(
                '${comment.comment}',
                style: const TextStyle(
                  fontSize: 13.0,
                  fontWeight:FontWeight.w300,
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );

}