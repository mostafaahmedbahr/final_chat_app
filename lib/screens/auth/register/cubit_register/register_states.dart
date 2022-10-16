abstract class ChatRegisterStates{}

class ChatRegisterInitialState extends ChatRegisterStates{}

class ChatRegisterLoadingState extends ChatRegisterStates{}

class ChatRegisterSuccessState extends ChatRegisterStates{}

class ChatRegisterErrorState extends ChatRegisterStates{
  final String error;
  ChatRegisterErrorState({required this.error});
}


class ChatRegisterGoogleLoadingState extends ChatRegisterStates{}

class ChatRegisterGoogleSuccessState extends ChatRegisterStates{}

class ChatRegisterGoogleErrorState extends ChatRegisterStates{
  final String error;
  ChatRegisterGoogleErrorState({required this.error});
}

class CreateUserLoadingState extends ChatRegisterStates{}

class CreateUserSuccessState extends ChatRegisterStates{}

class CreateUserErrorState extends ChatRegisterStates{
  final String error;
  CreateUserErrorState({required this.error});
}

class ChangeRegisterIconState extends ChatRegisterStates{}