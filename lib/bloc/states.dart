abstract class ChatStates{}

class ChatInitialState extends ChatStates{}

class ChatLogoutLoadingState extends ChatStates{}

class ChatLogoutSuccessState extends ChatStates{}

class ChatLogoutErrorState extends ChatStates{}

class GetAllUsersLoadingState extends ChatStates{}
class GetAllUsersSuccessState extends ChatStates{}
class GetAllUsersErrorState extends ChatStates{}

class ChangePhotoState extends ChatStates{}
class UpdateUserDateLoadingState extends ChatStates{}
class UpdateUserDateSuccessState extends ChatStates{}
class UpdateUserDateErrorState extends ChatStates{}

class SendMessageErrorState extends ChatStates{}
class SendMessageSuccessState extends ChatStates{}
class ReceiveMessageErrorState extends ChatStates{}
class ReceiveMessageSuccessState extends ChatStates{}


