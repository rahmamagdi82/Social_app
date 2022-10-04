import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:social_app/shared/components/components.dart';
import 'package:social_app/shared/components/cubit/cubit.dart';
import 'package:social_app/shared/components/cubit/states.dart';

import '../shared/components/constans.dart';
import '../shared/network/local/cash_helper.dart';

class EditProfileScreen extends StatelessWidget
{
  var nameController=TextEditingController();
  var bioController=TextEditingController();
  var phoneController=TextEditingController();


  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit,SocialStates>(
      listener: (BuildContext context, state) {  },
      builder: (BuildContext context, Object? state) {
        var user=SocialCubit.get(context).user;
        nameController.text=user.name!;
        bioController.text=user.bio!;
        phoneController.text=user.phone!;
        var profileImage=SocialCubit.get(context).profileImage;
        var coverImage=SocialCubit.get(context).coverImage;

        return Scaffold(
          appBar: appBar(
              context: context,
              title: 'Edit Profile',
              actions: [
                defultTextButton(
                  function: (){
                    SocialCubit.get(context).updateUser(
                        name: nameController.text,
                        bio: bioController.text,
                        phone: phoneController.text,
                    );
                  },
                  text: 'update',
                ),
                const SizedBox(width: 15.0,)
              ]
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  if(state is UpdateUserLoadingState)
                   LinearProgressIndicator(),
                  if(state is UpdateUserLoadingState)
                   SizedBox(height: 10.0,),
                  Container(
                    height: 190.0,
                    child: Stack(
                      alignment: AlignmentDirectional.bottomCenter,
                      children: [
                        Align(
                          child: Stack(
                            alignment: AlignmentDirectional.topEnd,
                            children: [
                              Container(
                                height: 140.0,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadiusDirectional.only(
                                    topStart: Radius.circular(4.0),
                                    topEnd: Radius.circular(4.0),
                                  ),
                                  image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image:(coverImage ==null)? NetworkImage('${user.cover}',):FileImage(coverImage) as ImageProvider,
                                  ),
                                ),
                              ),
                              IconButton(
                                icon:CircleAvatar(
                                  child: Icon(
                                    IconlyBroken.camera,
                                    size: 16.0,
                                  ),
                                ), onPressed: () {
                                  SocialCubit.get(context).getCoverImage();
                              },
                              ),
                            ],
                          ),
                          alignment: AlignmentDirectional.topCenter,
                        ),
                        Stack(
                          alignment: AlignmentDirectional.bottomEnd,
                          children: [
                            CircleAvatar(
                              radius: 64.0,
                              backgroundColor: Theme
                                  .of(context)
                                  .scaffoldBackgroundColor,
                              child: CircleAvatar(
                                backgroundImage: profileImage==null ? NetworkImage('${user.image}'):FileImage(profileImage) as ImageProvider,
                                radius: 60.0,
                              ),
                            ),
                            IconButton(
                              icon:CircleAvatar(
                                child: Icon(
                                  IconlyBroken.camera,
                                  size: 16.0,
                                ),
                              ), onPressed: () {
                                SocialCubit.get(context).getProfileImage();
                            },
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20.0,),
                  if(SocialCubit.get(context).profileImage != null || SocialCubit.get(context).coverImage != null)
                   Row(
                    children: [
                      if(SocialCubit.get(context).profileImage != null )
                      Expanded(
                        child: Column(
                          children: [
                            defultButton(
                              function: (){
                                SocialCubit.get(context).uploadProfileImage(
                                    name: nameController.text,
                                    bio: bioController.text,
                                    phone: phoneController.text,
                                );
                              },
                              text: 'upload profile',
                              uperCase: true,
                            ),
                            if(state is UpdateUserLoadingState)
                              SizedBox(height: 5.0,),
                            if(state is UpdateUserLoadingState)
                              LinearProgressIndicator(),
                          ],
                        ),
                      ),
                      SizedBox(width: 5.0,),
                      if( SocialCubit.get(context).coverImage != null)
                      Expanded(
                        child: Column(
                          children: [
                            defultButton(
                              function: (){
                                SocialCubit.get(context).uploadCoverImage(
                                    name: nameController.text,
                                    bio: bioController.text,
                                    phone: phoneController.text,
                                );
                              },
                              text: 'upload cover',
                              uperCase: true,
                            ),
                            if(state is UpdateUserLoadingState)
                              SizedBox(height: 5.0,),
                            if(state is UpdateUserLoadingState)
                              LinearProgressIndicator(),
                          ],
                        ),
                      ),
                    ],
                  ),
                  if(SocialCubit.get(context).profileImage != null || SocialCubit.get(context).coverImage != null)
                    SizedBox(height: 20.0,),
                  defultTextFormFeild(
                    validate: (value){
                      if(value!.isEmpty){
                        return 'name must not be empty';
                      }else
                      {
                        return null;
                      }
                    },
                    control: nameController,
                    type: TextInputType.name,
                    lable: 'Name',
                    prefix: IconlyBroken.user2,
                  ),
                  SizedBox(height: 10.0,),
                  defultTextFormFeild(
                    validate: (value){
                      if(value!.isEmpty){
                        return 'bio must not be empty';
                      }else
                      {
                        return null;
                      }
                    },
                    control: bioController,
                    type: TextInputType.text,
                    lable: 'Bio',
                    prefix: IconlyBroken.infoCircle,
                  ),
                  SizedBox(height: 10.0,),
                  defultTextFormFeild(
                    validate: (value){
                      if(value!.isEmpty){
                        return 'please enter your phone';
                      }else
                      {
                        return null;
                      }
                    },
                    control: phoneController,
                    type: TextInputType.phone,
                    lable: 'Phone',
                    prefix: Icons.phone,
                  ),
                ],
              ),
            ),
          ),
        );
      },

    );
  }

}