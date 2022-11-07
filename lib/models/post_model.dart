class PostModel{
  String? name;
  String? uId;
  String? image;
  String? postImage;
  String? text;
  String? dateTime;
  List<CommentModel> list=[];
  List<LikeModel> likesList=[];

  PostModel({
    this.name,
    this.uId,
    this.image,
    this.postImage,
    this.text,
    this.dateTime,
  });

  PostModel.fromJson( Map<String,dynamic>? json){
    name=json!['name'];
    uId=json['uId'];
    image=json['image'];
    postImage=json['postImage'];
    text=json['text'];
    dateTime=json['dateTime'];
    json['comments'].forEach((element){
        list.add(CommentModel.fromJson(element));
    });
    json['likes'].forEach((element){
      likesList.add(LikeModel.fromJson(element));
    });
  }

  Map<String,dynamic> toMap(){
    return {
      'name':name,
      'uId':uId,
      'image':image,
      'postImage':postImage,
      'text':text,
      'dateTime':dateTime,
      'comments':[],
      'likes':[]
    };
  }
}

class CommentModel{
  String? comment;
  String? name;
  String? image;

  CommentModel({
    this.comment,
    this.name,
    this.image
});

  CommentModel.fromJson(Map<String,dynamic>? json){
    comment=json!['comment'];
    name=json['userName'];
    image=json['image'];
  }

  Map<String,dynamic> toMap(){
    return {
      'comment':comment,
      'userName':name,
      'image':image,
    };
  }
}

class LikeModel{
  bool? like;
  String? name;
  String? image;

  LikeModel({
    this.like,
    this.name,
    this.image
  });

  LikeModel.fromJson(Map<String,dynamic>? json){
    like=json!['like'];
    name=json['userName'];
    image=json['image'];
  }

  Map<String,dynamic> toMap(){
    return {
      'like':like,
      'userName':name,
      'image':image,
    };
  }
}