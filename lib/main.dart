import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/shared/components/constans.dart';
import 'package:social_app/shared/components/cubit/bloc_observe.dart';
import 'package:social_app/shared/components/cubit/cubit.dart';
import 'package:social_app/shared/network/local/cash_helper.dart';
import 'package:social_app/shared/styles/themes.dart';

import 'layout/home.dart';
import 'modules/login/login.dart';
import 'shared/components/cubit/states.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  print(message.data.toString());
}

void main() async {
  Widget widget;

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  var token =await FirebaseMessaging.instance.getToken();
  print(token);

  FirebaseMessaging.onMessage.listen((event) {
    print(event.data.toString());
  });

  FirebaseMessaging.onMessageOpenedApp.listen((event) {
    print(event.data.toString());
  });
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  await CashHelper.initial();
  uId=CashHelper.getData(key: "uId");
  BlocOverrides.runZoned(
        () {
          if(uId != null)
          {
            widget=Home();
          }else
          {
            widget=Login();
          }
          runApp(MyApp(widget: widget,)
          );
    },
    blocObserver: MyBlocObserver(),
  );
}

class MyApp extends StatelessWidget {
  Widget widget;
   MyApp({Key? key,required this.widget}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context)  =>SocialCubit()..getUser()..getPosts(),
      child: BlocConsumer<SocialCubit,SocialStates>(
        builder: (BuildContext context, state) {
          return MaterialApp(
            home: widget,
            theme: lightTheme(),
            debugShowCheckedModeBanner: false,
          );
        },
        listener: (BuildContext context, Object? state) {  },

      ),
    );
  }
}