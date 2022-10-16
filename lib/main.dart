import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_chat_app_using_firebase_with_more_things/bloc/cubit.dart';
import 'package:new_chat_app_using_firebase_with_more_things/screens/auth/login/login_screen.dart';
import 'package:new_chat_app_using_firebase_with_more_things/screens/home.dart';
 import 'package:shared_preferences/shared_preferences.dart';

import 'h.dart';
bool? isLogin;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  var user = FirebaseAuth.instance.currentUser;
  SharedPreferences prefs =await SharedPreferences.getInstance();
  if(user == null)
  {
    isLogin = false;
  }
  else
  {
    isLogin =true;
  }
  runApp(  MyApp(prefs: prefs,));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key,required this.prefs}) : super(key: key);
  final SharedPreferences prefs;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ChatCubit()..testGetAllUsers(),
      //..getCurrentUserData()..getAllUsers()
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home:isLogin == false ? LoginScreen() : const HomeScreen(),
      ),
    );
  }
}
