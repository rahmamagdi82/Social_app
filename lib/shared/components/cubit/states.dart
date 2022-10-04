abstract class SocialStates {}

class InitialState extends SocialStates {}

class GetUserLoadingState extends SocialStates {}

class GetUserErrorState extends SocialStates
{
  final String error;
  GetUserErrorState(this.error);
}

class GetUserSuccessState extends SocialStates {}

class GetCommentsLoadingState extends SocialStates {}

class GetCommentsErrorState extends SocialStates
{
  final String error;
  GetCommentsErrorState(this.error);
}

class GetCommentsSuccessState extends SocialStates {}

class GetAllUserLoadingState extends SocialStates {}

class GetAllUserErrorState extends SocialStates
{
  final String error;
  GetAllUserErrorState(this.error);
}

class GetAllUserSuccessState extends SocialStates {}

class GetAllChatsSuccessState extends SocialStates {}

class ChangeState extends SocialStates {}

class NewPostState extends SocialStates {}

class ImageProfilePickedSuccessState extends SocialStates {}

class ImageProfilePickedErrorState extends SocialStates {}

class ImageCoverPickedSuccessState extends SocialStates {}

class ImageCoverPickedErrorState extends SocialStates {}

class UploadImageProfileSuccessState extends SocialStates {}

class UploadImageProfileErrorState extends SocialStates {}

class UploadImageCoverSuccessState extends SocialStates {}

class UploadImageCoverErrorState extends SocialStates {}

class UpdateUserLoadingState extends SocialStates {}

class UpdateUserErrorState extends SocialStates {}

class UpdateUserSuccessState extends SocialStates {}

class UploadPostLoadingState extends SocialStates {}

class UploadPostSuccessState extends SocialStates {}

class UploadPostErrorState extends SocialStates {}

class ImagePostPickedSuccessState extends SocialStates {}

class ImagePostPickedErrorState extends SocialStates {}

class ImagePostRemovedSuccessState extends SocialStates {}

class GetPostLoadingState extends SocialStates {}

class GetPostErrorState extends SocialStates
{
  final String error;
  GetPostErrorState(this.error);
}

class GetPostSuccessState extends SocialStates {}

class CommentPostSuccessState extends SocialStates {}

class CommentPostErrorState extends SocialStates {
  final String error;
  CommentPostErrorState(this.error);
}

class LikePostErrorState extends SocialStates
{
  final String error;
  LikePostErrorState(this.error);
}

class LikePostSuccessState extends SocialStates {}

class SendMessageErrorState extends SocialStates {}

class SendMessageSuccessState extends SocialStates {}

class GetMessageErrorState extends SocialStates {}

class GetMessageSuccessState extends SocialStates {}
