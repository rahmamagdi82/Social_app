class Users{
 String? name;
 String? email;
 String? phone;
 String? uId;
 String? image;
 String? cover;
 String? bio;
 bool? isEmailVerified;

 Users({
   this.name,
   this.email,
   this.phone,
   this.uId,
   this.image,
   this.cover,
   this.bio,
   this.isEmailVerified
});

 Users.fromJson( Map<String,dynamic>? json){
  name=json!['name'];
  email=json['email'];
  phone=json['phone'];
  uId=json['uId'];
  image=json['image'];
  cover=json['cover'];
  isEmailVerified=json['isEmailVerified'];
  bio=json['bio'];
 }

 Map<String,dynamic> toMap(){
  return {
   'name':name,
   'email':email,
   'phone':phone,
   'uId':uId,
   'image':image,
   'cover':cover,
   'isEmailVerified':isEmailVerified,
   'bio':bio,
  };
 }
}