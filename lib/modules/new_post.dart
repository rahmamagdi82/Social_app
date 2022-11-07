import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:social_app/shared/components/components.dart';
import 'package:social_app/shared/components/cubit/cubit.dart';
import 'package:social_app/shared/components/cubit/states.dart';

class NewPostScreen extends StatelessWidget {
  var textController=TextEditingController();

  NewPostScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit,SocialStates>(
      listener: (context,state){},
      builder: (context,state) {
        var imagePost = SocialCubit.get(context).postImage;
        return Scaffold(
          appBar: appBar(context: context, title: 'Create Post', actions: [
            defultTextButton(
              function: () {
                var now = DateTime.now();
                if (SocialCubit.get(context).postImage == null && textController.text.isNotEmpty) {
                  SocialCubit.get(context).createPost(
                      dateTime: now.toString(),
                      text: textController.text
                  );
                } else {
                  if(textController.text.isNotEmpty) {
                    SocialCubit.get(context).uploadPostImage(
                      dateTime: now.toString(),
                      text: textController.text
                  );
                  }
                }
                textController.text='';
                Navigator.of(context).pop();
                SocialCubit.get(context).getPosts();
              },
              text: 'post',
            ),
          ]),
          body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(children: [
              if(state is UploadPostLoadingState)
                const LinearProgressIndicator(),
              if(state is UploadPostLoadingState)
                const SizedBox(height: 10,),
              Row(children: [
                CircleAvatar(
                  backgroundImage: NetworkImage('${SocialCubit.get(context).user.image}'),
                  radius: 25.0,
                ),
                const SizedBox(
                  width: 15.0,
                ),
                Expanded(
                  child: Text(
                    '${SocialCubit.get(context).user.name}',
                    style: const TextStyle(
                      height: 1.4,
                    ),
                  ),
                ),
              ]),
              Expanded(
                child: TextFormField(
                  controller: textController,
                  style: const TextStyle(
                      color: Colors.black
                  ),
                  decoration: const InputDecoration(
                    hintText: 'What is in your mind ...',
                    border: InputBorder.none,
                  ),
                ),
              ),
              if(imagePost != null)
                const SizedBox(
                width: 15.0,
              ),
              if(imagePost != null)
               Stack(
                alignment: AlignmentDirectional.topEnd,
                children: [
                  Container(
                    height: 140.0,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4.0),
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: FileImage(imagePost),
                      ),
                    ),
                  ),
                  IconButton(
                    icon: const CircleAvatar(
                      child: Icon(
                        Icons.close,
                        size: 16.0,
                      ),
                    ), onPressed: () {
                    SocialCubit.get(context).removePostImage();
                  },
                  ),
                ],
              ),
              if(imagePost != null)
                const SizedBox(
                width: 20.0,
              ),
              Row(
                children: [
                  Expanded(
                    child: TextButton(
                      onPressed: () {
                        SocialCubit.get(context).getPostImage();
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Icon(
                            IconlyBroken.image,
                          ),
                          Text(
                            'add photo',
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: TextButton(
                      onPressed: () {},
                      child: const Text(
                          '# tags'
                      ),
                    ),
                  ),
                ],
              ),
            ]),
          ),
        );
      }
    );
  }
}
