import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:social_app/models/message_model.dart';
import 'package:social_app/shared/components/cubit/cubit.dart';
import 'package:social_app/shared/components/cubit/states.dart';
import 'package:social_app/shared/styles/colors.dart';

import '../models/users_model.dart';

class ChatDetails extends StatelessWidget{
  Users? model;
  ChatDetails({Key? key, this.model}) : super(key: key);
  var messageController=TextEditingController();
  var date=DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        SocialCubit.get(context).getMessage(receiveId: '${model!.uId}');
        return BlocConsumer<SocialCubit,SocialStates>(
          listener: (context,state){},
          builder: (context,state){
            return Scaffold(
                  appBar: AppBar(
                    titleSpacing: 0.0,
                    title: Row(
                      children: [
                        CircleAvatar(
                          backgroundImage: NetworkImage('${model!.image}'),
                          radius: 20.0,
                        ),
                        const SizedBox(
                          width: 15.0,
                        ),
                        Text(
                          '${model!.name}',
                        ),
                      ],
                    ),
                  ),
                  body: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        children: [
                          if(SocialCubit.get(context).messages.length == 0)
                            const Text('Start Chatting'),
                          Expanded(
                            child: ListView.separated(
                                itemBuilder: (context,index){
                                  var message=SocialCubit.get(context).messages[index];
                                  if(SocialCubit.get(context).user.uId==message.senderId)
                                  {
                                   return buildMyMessage(message);
                                  }else
                                    {
                                     return buildMessage(message);
                                    }
                                },
                                separatorBuilder: (context,index)=>const SizedBox(height: 15.0,),
                                itemCount:SocialCubit.get(context).messages.length,
                    ),
                          ),
                          Container(
                            clipBehavior: Clip.antiAliasWithSaveLayer,
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.grey,
                                width: 1.0,
                              ),
                              borderRadius: BorderRadius.circular(15.0),
                            ),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 15.0),
                                    child: TextFormField(
                                      style: const TextStyle(color: Colors.black),
                                      keyboardType: TextInputType.text,
                                      controller: messageController,
                                      decoration: const InputDecoration(
                                        hintText: 'Enter your message ... ',
                                        border: InputBorder.none,
                                      ),
                                    ),
                                  ),
                                ),
                                  Container(
                                  height: 50.0,
                                  color: defultColor,
                                  child: MaterialButton(
                                    onPressed: (){
                                      if(messageController.text.isNotEmpty) {
                                        SocialCubit.get(context).sendMessage(
                                        receiverId: '${model!.uId}',
                                        date: date.toString(),
                                        text: messageController.text,
                                      );
                                      }
                                      messageController.text='';
                                    },
                                    minWidth: 1.0,
                                    child: const Icon(
                                      IconlyBroken.send,
                                      size: 16.0,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),

                );
              },
            );
          },
        );
      }



  Widget buildMessage(MessageModel message)=>Align(
    alignment: AlignmentDirectional.centerStart,
    child: Container(
        padding: const EdgeInsets.symmetric(vertical: 5.0,horizontal: 10.0),
        decoration: BoxDecoration(
          color: Colors.grey[300],
          borderRadius: const BorderRadiusDirectional.only(
            topStart: Radius.circular(10.0),
            topEnd: Radius.circular(10.0),
            bottomEnd:Radius.circular(10.0),
          ),
        ),
        child: Text('${message.text}')),
  );

  Widget buildMyMessage(MessageModel message)=>Align(
    alignment: AlignmentDirectional.centerEnd,
    child: Container(
        padding: const EdgeInsets.symmetric(vertical: 5.0,horizontal: 10.0),
        decoration: BoxDecoration(
          color: defultColor.withOpacity(0.2),
          borderRadius: const BorderRadiusDirectional.only(
            topStart: Radius.circular(10.0),
            topEnd: Radius.circular(10.0),
            bottomStart:Radius.circular(10.0),
          ),
        ),
        child: Text('${message.text}')),
  );

}