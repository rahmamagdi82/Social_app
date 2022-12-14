import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:social_app/models/message_model.dart';
import 'package:social_app/models/post_model.dart';
import 'package:social_app/models/users_model.dart';
import 'package:social_app/modules/chats.dart';
import 'package:social_app/modules/feeds.dart';
import 'package:social_app/modules/setting.dart';
import 'package:social_app/modules/users.dart';
import 'package:social_app/shared/components/constans.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

import 'states.dart';

class SocialCubit extends Cubit<SocialStates> {
  SocialCubit() : super(InitialState());
  static SocialCubit get(context) => BlocProvider.of(context);

  List screens = [const FeedsScreen(), const ChatsScreen(), const UsersScreen(), const SettingScreen()];
  List titles = [
    'Home',
    'Chats',
    'Users',
    'Settings',
  ];
  int currentIndex = 0;
  void changeScreens(int x) {
    if(x==3 || x ==1){
      getAllUsers();
    }
    if(x==0){
      getPosts();
    }
    if (x == 2) {
      emit(NewPostState());
    } else {
      currentIndex = x;
      emit(ChangeState());
    }
  }

  Users user = Users();
  void getUser() {
    emit(GetUserLoadingState());
    FirebaseFirestore.instance.collection('users').doc(uId).get().then((value) {
      user = Users.fromJson(value.data());
      emit(GetUserSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(GetUserErrorState(error.toString()));
    });
  }

  File? profileImage;
  var picker = ImagePicker();
  Future<void> getProfileImage() async {
    var pickFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickFile != null) {
      profileImage = File(pickFile.path);
      emit(ImageProfilePickedSuccessState());
    } else {
      print('No image selected');
      emit(ImageProfilePickedErrorState());
    }
  }

  File? coverImage;
  Future<void> getCoverImage() async {
    var pickFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickFile != null) {
      coverImage = File(pickFile.path);
      emit(ImageProfilePickedSuccessState());
    } else {
      print('No image selected');
      emit(ImageProfilePickedErrorState());
    }
  }

  void uploadProfileImage({
    required String name,
    required String bio,
    required String phone,
}) {
    emit(UpdateUserLoadingState());
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('users/${(Uri.file(profileImage!.path).pathSegments.last)}')
        .putFile(profileImage!)
        .then((value) => {
              value.ref.getDownloadURL().then((value) {
                updateUser(
                    name: name,
                    bio: bio,
                    phone: phone,
                  image: value,
                );
              }).catchError((error) {
                print(error.toString());
                emit(UploadImageProfileErrorState());
              })
            })
        .catchError((error) {
      print(error.toString());
      emit(UploadImageProfileErrorState());
    });
  }


  void uploadCoverImage({
    required String name,
    required String bio,
    required String phone,
}) {
    emit(UpdateUserLoadingState());
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('users/${(Uri.file(coverImage!.path).pathSegments.last)}')
        .putFile(coverImage!)
        .then((value) => {
              value.ref.getDownloadURL().then((value) {
                updateUser(
                  name: name,
                  bio: bio,
                  phone: phone,
                  cover: value,
                );
              }).catchError((error) {
                print(error.toString());
                emit(UploadImageCoverErrorState());
              })
            })
        .catchError((error) {
      print(error.toString());
      emit(UploadImageCoverErrorState());
    });
  }

  void updateUser({
    required String name,
    required String bio,
    required String phone,
    String? image,
    String? cover,
  }) {
    Users model = Users(
      name: name,
      email: user.email,
      phone: phone,
      image: image??user.image,
      cover: cover??user.cover,
      uId: user.uId,
      bio: bio,
      isEmailVerified: user.isEmailVerified
    );
    FirebaseFirestore.instance.collection('posts').where("uId",isEqualTo: uId).get().then((value) {
      value.docs.forEach((element) {
        element.reference.update({
          'name':name,
          'image':image??user.image,
        });
      });
    });
    FirebaseFirestore.instance
        .collection('users')
        .doc(user.uId)
        .update(model.toMap())
        .then((value) {
      getUser();
    }).catchError((error) {
      print(error.toString());
      emit(UpdateUserErrorState());
    });
  }

  File? postImage;
  Future<void> getPostImage() async {
    var pickFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickFile != null) {
      postImage = File(pickFile.path);
      emit(ImagePostPickedSuccessState());
    } else {
      print('No image selected');
      emit(ImagePostPickedErrorState());
    }
  }

  void uploadPostImage({
    required String dateTime,
    required String text,
}){
    emit(UploadPostLoadingState());
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('posts/${(Uri.file(postImage!.path).pathSegments.last)}')
        .putFile(postImage!)
        .then((value) => {
      value.ref.getDownloadURL().then((value) {
        createPost(dateTime: dateTime, text: text, postImage: value);
      }).catchError((error) {
        print(error.toString());
        emit(UploadPostErrorState());
      })
    })
        .catchError((error) {
      print(error.toString());
      emit(UploadPostErrorState());
    });
  }

  void createPost({
    required String dateTime,
    required String text,
    String? postImage,
  }) {
    PostModel model = PostModel(
      name: user.name,
      image: user.image,
      text: text,
      uId: user.uId,
      dateTime: dateTime,
      postImage: postImage??''
    );
    FirebaseFirestore.instance
        .collection('posts')
        .add(model.toMap())
        .then((value) {
emit(UploadPostSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(UploadPostErrorState());
    });
  }

  void removePostImage(){
    postImage=null;
    emit(ImagePostRemovedSuccessState());
  }

  List<PostModel> posts=[];
  List<String> postId=[];
   void getPosts(){
    posts=[];
    postId=[];
    emit(GetPostLoadingState());
    FirebaseFirestore.instance.collection('posts').get().then((value){
      value.docs.forEach((element) {
          posts.add(PostModel.fromJson(element.data()));
          postId.add(element.id);
          emit(GetPostSuccessState());
      });
    }).catchError((error){
      print(error.toString());
      emit(GetPostErrorState(error.toString()));
    });
   }

  List likes=[];
   bool check=false;
  void likePost(String postId,List<LikeModel> list){
    likes=[];
      LikeModel likeModel= LikeModel(
      like:true,
      image:user.image,
      name:user.name,
    );
    list.forEach((element) {
      if(element.name == user.name){
        check=true;
      }
    });
    if(!check){
      list.add(likeModel);
      list.forEach((element) {
        likes.add(element.toMap());
      });
    }else{
      list.forEach((element) {
        likes.add(element.toMap());
      });
    }
    FirebaseFirestore
        .instance
        .collection('posts')
        .doc(postId)
        .update({'likes':likes}).then((value) {
          emit(LikePostSuccessState());
        }).catchError((error){
      emit(LikePostErrorState(error.toString()));
    });
  }

  List comments=[];
  void commentPost(String postId,List<CommentModel> list,String text){
    CommentModel comment= CommentModel(
      comment:text,
      image:user.image,
      name:user.name,
    );
    list.add(comment);
    list.forEach((element) {
      comments.add(element.toMap());
    });
    FirebaseFirestore
        .instance
        .collection('posts')
        .doc(postId)
        .update({'comments':comments}).then((value) {
      emit(CommentPostSuccessState());
    }).catchError((error){
      emit(CommentPostErrorState(error.toString()));
    });
  }

  List<Users> users=[];
  List<Users> chats=[];
  void getAllUsers(){
    users=[];
    chats=[];
    if(users.length == 0)
    {
      emit(GetAllUserLoadingState());
      FirebaseFirestore
          .instance
          .collection('users')
          .get().then((value) {
        value.docs.forEach((element) {
          if(element.data()['uId'] != user.uId) {
            users.add(Users.fromJson(element.data()));
            element.reference.collection('chats').doc(user.uId).collection('messages').get().then((value) {
              if(value.docs.length > 0){
                chats.add(Users.fromJson(element.data()));
                emit(GetAllChatsSuccessState());
              }
            });
          }
          emit(GetAllUserSuccessState());
        });
      }).catchError((error){
        print(error.toString());
        emit(GetAllUserErrorState(error));
      });
    }
  }

  void sendMessage({
   required String receiverId,
    required String date,
    required String text,
}){
    MessageModel message=MessageModel(
      senderId: user.uId,
      receiverId: receiverId,
      date: date,
      text: text,
    );
    FirebaseFirestore.instance
        .collection('users')
        .doc(user.uId)
        .collection('chats').doc(receiverId).collection('messages').add(message.toMap()).then((value) {
          emit(SendMessageSuccessState());
    }).catchError((error){
      emit(SendMessageErrorState());
    });

    FirebaseFirestore.instance
        .collection('users')
        .doc(receiverId)
        .collection('chats').doc(user.uId).collection('messages').add(message.toMap()).then((value) {
      emit(SendMessageSuccessState());
    }).catchError((error){
      emit(SendMessageErrorState());
    });
  }

  List<MessageModel> messages=[];
  void getMessage({
  required String receiveId,
}){
    FirebaseFirestore.instance
        .collection('users')
        .doc(user.uId)
        .collection('chats')
        .doc(receiveId)
        .collection('messages').orderBy('date')
        .snapshots()
        .listen((event) {
      messages=[];
      event.docs.forEach((element) {
            messages.add(MessageModel.fromJson(element.data()));
            emit(GetMessageSuccessState());
          });
    });
  }
}

// image: 'https://t4.ftcdn.net/jpg/02/18/22/33/240_F_218223302_dD8ur4d3HNSX4KaQB0KhzyILk3CSsE7M.jpg',
// cover: 'https://img.freepik.com/free-photo/beautiful-scenery-pathway-forest-with-trees-covered-with-frost_181624-42376.jpg?t=st=1657003515~exp=1657004115~hmac=2e2c707cdf8c536d1f815263bfa29ed240e0f30e63dc4cf38ff340dc0daf90fe&w=996',
//
