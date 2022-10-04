import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:social_app/models/post_model.dart';
import 'package:social_app/modules/likes_page.dart';
import 'package:social_app/shared/components/cubit/cubit.dart';

import '../shared/components/components.dart';
import '../shared/components/cubit/states.dart';
import 'comment_page.dart';

class FeedsScreen extends StatelessWidget {
  const FeedsScreen({Key? key}) : super(key: key);

  @override

  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit,SocialStates>(
       listener: (context,state){},
      builder: (context,state){
         return ConditionalBuilder(
           condition: SocialCubit.get(context).posts.length > 0,
           builder: (BuildContext context) {
             return SingleChildScrollView(
               physics: const BouncingScrollPhysics(),
               child: Column(
                 children: [
                   Card(
                     clipBehavior: Clip.antiAliasWithSaveLayer,
                     elevation: 5.0,
                     margin: const EdgeInsets.all(8.0),
                     child: Stack(alignment: AlignmentDirectional.bottomEnd, children: [
                       const Image(
                         image: NetworkImage(
                           'https://t3.ftcdn.net/jpg/02/86/68/34/240_F_286683484_kh9a1jEn0SzcV2ZaGqoH2DrNKgnRkfUL.jpg',
                         ),
                         fit: BoxFit.cover,
                         height: 200.0,
                         width: double.infinity,
                       ),
                       Padding(
                         padding: const EdgeInsets.all(8.0),
                         child: Text(
                           'communicate with friends',
                           style: Theme.of(context)
                               .textTheme
                               .subtitle1!
                               .copyWith(color: Colors.white, fontSize: 16.0),
                         ),
                       ),
                     ]),
                   ),
                   ListView.separated(
                     shrinkWrap: true,
                     physics: const NeverScrollableScrollPhysics(),
                     itemBuilder: (context, index) => buildPostItem(SocialCubit.get(context).posts[index],context,index),
                     separatorBuilder:(context,index)=> const SizedBox(height: 10.0,),
                     itemCount: SocialCubit.get(context).posts.length,
                   ),
                   const SizedBox(height: 10.0,),
                 ],
               ),
             );
           },
           fallback: (context)=>const Center(child: CircularProgressIndicator(),),
         );
      },
    );
  }

  Widget buildPostItem(PostModel model,context,int index) => Card(
        clipBehavior: Clip.antiAliasWithSaveLayer,
        elevation: 5.0,
        margin: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                   CircleAvatar(
                    backgroundImage: NetworkImage('${model.image}'),
                    radius: 25.0,
                  ),
                  const SizedBox(
                    width: 15.0,
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              '${model.name}',
                              style: const TextStyle(
                                height: 1.4,
                              ),
                            ),
                            const SizedBox(
                              width: 5.0,
                            ),
                            const Icon(
                              Icons.check_circle,
                              color: Colors.blue,
                              size: 16.0,
                            ),
                          ],
                        ),
                        Text(
                          '${model.dateTime}',
                          style: Theme.of(context).textTheme.caption!.copyWith(
                                height: 1.4,
                              ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    width: 15.0,
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.more_horiz,
                      size: 16.0,
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 15.0),
                child: Container(
                  width: double.infinity,
                  height: 1.0,
                  color: Colors.grey[300],
                ),
              ),
              Text(
                '${model.text}',
                style: Theme.of(context).textTheme.subtitle1!.copyWith(
                      color: Colors.black,
                    ),
              ),
              // Padding(
              //   padding: const EdgeInsets.only(
              //     bottom: 10.0,
              //     top: 5.0,
              //   ),
              //   child: Container(
              //     width: double.infinity,
              //     child: Wrap(
              //       children: [
              //         Padding(
              //           padding: const EdgeInsetsDirectional.only(end: 6.0),
              //           child: Container(
              //             height: 25.0,
              //             child: MaterialButton(
              //               onPressed: () {},
              //               minWidth: 1.0,
              //               padding: EdgeInsets.zero,
              //               child: Text(
              //                 '#Software',
              //                 style:
              //                     Theme.of(context).textTheme.caption!.copyWith(
              //                           color: Colors.blue,
              //                         ),
              //               ),
              //             ),
              //           ),
              //         ),
              //       ],
              //     ),
              //   ),
              // ),
              if(model.postImage != '')
               Padding(
                padding: const EdgeInsets.only(top: 15.0),
                child: Container(
                  width: double.infinity,
                  height: 140.0,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4.0),
                    image:  DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage(
                        '${model.postImage}',
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 5.0),
                child: Row(
                  children: [
                    Expanded(
                      child: InkWell(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 5.0),
                          child: Row(
                            children: [
                              const Icon(
                                IconlyBroken.heart,
                                size: 16.0,
                                color: Colors.red,
                              ),
                              const SizedBox(
                                width: 5.0,
                              ),
                             Text(
                                '${SocialCubit.get(context).likesInPost[index]}',
                                style: Theme.of(context).textTheme.caption,
                              ),
                            ],
                          ),
                        ),
                        onTap: () {
                          navigation(context, LikesPage(num: index,));
                        },
                      ),
                    ),
                    Expanded(
                      child: InkWell(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 5.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              const Icon(
                                IconlyBroken.chat,
                                size: 16.0,
                                color: Colors.amber,
                              ),
                              const SizedBox(
                                width: 5.0,
                              ),
                              Text(
                                '${SocialCubit.get(context).commentsInPost[index]}',
                                style: Theme.of(context).textTheme.caption,
                              ),
                            ],
                          ),
                        ),
                        onTap: () {
                          navigation(context, CommentPage(postId: SocialCubit.get(context).postId[index],num: index,));
                        },
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsetsDirectional.only(bottom: 10.0),
                child: Container(
                  width: double.infinity,
                  height: 1.0,
                  color: Colors.grey[300],
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        navigation(context, CommentPage(postId: SocialCubit.get(context).postId[index],num: index,));
                      },
                      child: Row(
                        children: [
                           CircleAvatar(
                            backgroundImage: NetworkImage(
                                '${SocialCubit.get(context).user.image}'),
                            radius: 15.0,
                          ),
                          const SizedBox(
                            width: 15.0,
                          ),
                          Expanded(
                            child:
                            Text(
                              'write a comment....',
                              style: Theme.of(context)
                                  .textTheme
                                  .caption!
                                  .copyWith(),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  InkWell(
                    child: Row(
                      children: [
                        const Icon(
                          IconlyBroken.heart,
                          size: 16.0,
                          color: Colors.red,
                        ),
                        const SizedBox(
                          width: 5.0,
                        ),
                        Text(
                          'Like',
                          style: Theme.of(context).textTheme.caption,
                        ),
                      ],
                    ),
                    onTap: () {
                      SocialCubit.get(context).likePost(SocialCubit.get(context).postId[index]);
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      );
}
