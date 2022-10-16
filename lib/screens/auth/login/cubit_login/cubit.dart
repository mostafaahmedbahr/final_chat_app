 import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_chat_app_using_firebase_with_more_things/screens/auth/login/cubit_login/states.dart';

class ChatLoginCubit extends Cubit<ChatLoginStates>
{
  ChatLoginCubit() : super(ChatLoginInitialState());

  static ChatLoginCubit get(context) => BlocProvider.of(context);
  var emailCon = TextEditingController();
  var passCon = TextEditingController();
  bool isVisible = true;
   void changeSuffixIcon()
  {
    isVisible =! isVisible;
    emit(ChangeIconState());
  }

  void login()async
  {
    emit(ChatLoginLoadingState());
    FirebaseAuth.instance.signInWithEmailAndPassword(
      email: emailCon.text,
      password: passCon.text,
    ).then((value)
    {
      emit(ChatLoginSuccessState());
      print("success");
    }).catchError((error)
    {
      emit(ChatLoginErrorState(error: error.toString()));
      print("error in login ${error.toString()}");
    });
  }

}