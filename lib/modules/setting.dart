import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:social_app/modules/edit_profile.dart';
import 'package:social_app/shared/components/components.dart';
import 'package:social_app/shared/components/cubit/cubit.dart';
import 'package:social_app/shared/components/cubit/states.dart';

import '../shared/network/local/cash_helper.dart';
import 'login/login.dart';

class SettingScreen extends StatelessWidget
{
  const SettingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit,SocialStates>(
      listener: (context, states){},
      builder: (context, states) {
        var user=SocialCubit.get(context).user;
       return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Container(
                height: 190.0,
                child: Stack(
                  alignment: AlignmentDirectional.bottomCenter,
                  children: [
                    Align(
                      child: Container(
                        height: 140.0,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: const BorderRadiusDirectional.only(
                            topStart: Radius.circular(4.0),
                            topEnd: Radius.circular(4.0),
                          ),
                          image: DecorationImage(
                            fit: BoxFit.cover,
                            image: NetworkImage(
                              '${user.cover}',
                            ),
                          ),
                        ),
                      ),
                      alignment: AlignmentDirectional.topCenter,
                    ),
                    CircleAvatar(
                      radius: 64.0,
                      backgroundColor: Theme
                          .of(context)
                          .scaffoldBackgroundColor,
                      child: CircleAvatar(
                        backgroundImage: NetworkImage(
                            '${user.image}'),
                        radius: 60.0,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 5.0,),
              Text(
                '${user.name}',
                style: Theme
                    .of(context)
                    .textTheme
                    .bodyText1,
              ),
              Text(
                '${user.bio}',
                style: Theme
                    .of(context)
                    .textTheme
                    .caption,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20.0),
                child: Row(
                  children: [
                    Expanded(
                      child: InkWell(
                        onTap: (){},
                        child: Column(
                          children: [
                            Text(
                              '30',
                              style: Theme
                                  .of(context)
                                  .textTheme
                                  .bodyText1,
                            ),
                            Text(
                              'Post',
                              style: Theme
                                  .of(context)
                                  .textTheme
                                  .caption,
                            ),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: InkWell(
                        onTap: (){},
                        child: Column(
                          children: [
                            Text(
                              '50',
                              style: Theme
                                  .of(context)
                                  .textTheme
                                  .bodyText1,
                            ),
                            Text(
                              'Photos',
                              style: Theme
                                  .of(context)
                                  .textTheme
                                  .caption,
                            ),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: InkWell(
                        onTap: (){},
                        child: Column(
                          children: [
                            Text(
                              '150',
                              style: Theme
                                  .of(context)
                                  .textTheme
                                  .bodyText1,
                            ),
                            Text(
                              'Followers',
                              style: Theme
                                  .of(context)
                                  .textTheme
                                  .caption,
                            ),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: InkWell(
                        onTap: (){},
                        child: Column(
                          children: [
                            Text(
                              '100',
                              style: Theme
                                  .of(context)
                                  .textTheme
                                  .bodyText1,
                            ),
                            Text(
                              'Followings',
                              style: Theme
                                  .of(context)
                                  .textTheme
                                  .caption,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () {  },
                      child: const Text('Add Photos'),
                    ),
                  ),
                  const SizedBox(width: 10.0,),
                  OutlinedButton(
                    onPressed: () {
                      navigation(context, EditProfileScreen());
                    },
                    child: const Icon(
                      IconlyBroken.edit,
                      size: 16.0,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 30.0,
              ),
              defultButton(
                  uperCase: true,
                  function: () {
                    CashHelper.removeData(key: 'uId').then((value) {
                      if (value) {
                        navigationAndFinish(context, Login());
                      }
                    });
                  },
                  text: "sign out"),
            ],
          ),
        );
      }
    );
  }
}