abstract class RegisterStates
{}

class RegisterInitialState extends RegisterStates
{}

class RegisterLoadingState extends RegisterStates
{}

class RegisterSuccessState extends RegisterStates
{}

class RegisterErrorState extends RegisterStates
{}

class RegisterCreateUserSuccessState extends RegisterStates
{
  final String uId;
  RegisterCreateUserSuccessState(this.uId);
}

class RegisterCreateUserErrorState extends RegisterStates
{}

class RegisterChangePasswordState extends RegisterStates
{}

