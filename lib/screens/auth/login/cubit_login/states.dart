abstract class ChatLoginStates{}

class ChatLoginInitialState extends ChatLoginStates{}

class ChatLoginLoadingState extends ChatLoginStates{}

class ChatLoginSuccessState extends ChatLoginStates{}

class ChatLoginErrorState extends ChatLoginStates{
  final String error;
  ChatLoginErrorState({required this.error});
}

class ChangeIconState extends ChatLoginStates{}