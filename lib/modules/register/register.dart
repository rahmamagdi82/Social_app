import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/modules/register/register_cubit/states.dart';
import 'package:social_app/shared/components/components.dart';
import 'package:social_app/shared/components/constans.dart';
import 'package:social_app/shared/components/cubit/cubit.dart';
import 'package:social_app/shared/network/local/cash_helper.dart';

import '../../layout/home.dart';
import 'register_cubit/cubit.dart';


class Register extends StatelessWidget
{
  var nameController=TextEditingController();
  var phoneController=TextEditingController();
  var emailController=TextEditingController();
  var passwordController=TextEditingController();
  var formKey=GlobalKey<FormState>();
  Register({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) =>RegisterCubit(),
      child: BlocConsumer<RegisterCubit,RegisterStates>(
        listener: (BuildContext context, state) {
          if(state is RegisterCreateUserSuccessState){
            CashHelper.putData(
                key: "uId",
                value: state.uId).then((value) {
              uId=CashHelper.getData(key: "uId");
              SocialCubit.get(context).getUser();
              navigationAndFinish(context, Home());
            });
          }
        },
        builder: (BuildContext context, Object? state) {
          return Scaffold(
            appBar: AppBar(),
            body:Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Form(
                    key:formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Register',
                          style: Theme.of(context).textTheme.headline4!.copyWith(
                            color: Colors.black,
                          ),
                        ),
                        Text(
                          'Register now to communicate with friends',
                          style: Theme.of(context).textTheme.bodyText1!.copyWith(
                            color: Colors.grey,
                          ),
                        ),
                        const SizedBox(height: 30.0,),
                        defultTextFormFeild(
                          validate: (value){
                            if(value!.isEmpty){
                              return 'please enter your name';
                            }else
                            {
                              return null;
                            }
                          },
                          control: nameController,
                          type: TextInputType.name,
                          lable: 'User Name',
                          prefix: Icons.person,
                        ),
                        const SizedBox(height: 15.0,),
                        defultTextFormFeild(
                          validate: (value){
                            if(value!.isEmpty){
                              return 'please enter your email';
                            }else
                            {
                              return null;
                            }
                          },
                          control: emailController,
                          type: TextInputType.emailAddress,
                          lable: 'Email Address',
                          prefix: Icons.email,
                        ),
                        const SizedBox(height: 15.0,),
                        defultTextFormFeild(
                          validate: (value){
                            if(value!.isEmpty){
                              return 'please enter your password';
                            }else
                            {
                              return null;
                            }
                          },
                          control: passwordController,
                          type: TextInputType.visiblePassword,
                          lable: 'Password',
                          prefix: Icons.lock,
                          suffix: RegisterCubit.get(context).icon,
                          obscure: RegisterCubit.get(context).obsecure,
                          show: (){
                            RegisterCubit.get(context).changeShowPassword();
                          },
                        ),
                        const SizedBox(height: 15.0,),
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
                        const SizedBox(height: 30.0,),
                        ConditionalBuilder(
                          condition: state is! RegisterLoadingState,
                          builder:(context)=> defultButton(
                            uperCase: true,
                            function: (){
                              if(formKey.currentState!.validate()){
                                RegisterCubit.get(context).userRegister(
                                  name: nameController.text,
                                  email: emailController.text,
                                  password: passwordController.text,
                                  phone: phoneController.text,
                                );
                              }
                            },
                            text: 'Register',
                          ),
                          fallback:(context)=> const Center(child: CircularProgressIndicator()),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },

      ),
    );

  }

}