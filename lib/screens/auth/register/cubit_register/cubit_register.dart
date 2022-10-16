import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_chat_app_using_firebase_with_more_things/model/user_model.dart';
 import 'package:new_chat_app_using_firebase_with_more_things/screens/auth/register/cubit_register/register_states.dart';
import 'package:google_sign_in/google_sign_in.dart';
 import 'package:uuid/uuid.dart';


class ChatRegisterCubit extends Cubit<ChatRegisterStates> {
  ChatRegisterCubit() : super(ChatRegisterInitialState());

  static ChatRegisterCubit get(context) => BlocProvider.of(context);


  bool isVisible = true;

  var currentUser = FirebaseAuth.instance.currentUser;
  void changeSuffixIcon() {
    isVisible = !isVisible;
    emit(ChangeRegisterIconState());
  }

  void register({
    required String name,
    required String email,
    required String phone,
    required String password,
  }) async
  {
    emit(ChatRegisterLoadingState());
    FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: email,
      password: password,
    ).then((value) {
      createUsers(
        email: email,
        img: "",
        name: name,
        phone: phone,
        uid: "${value.user?.uid}",
      );
      print(value.user?.uid);
      emit(ChatRegisterSuccessState());
      print("success");
    }).catchError((error) {
      emit(ChatRegisterErrorState(error: error.toString()));
      print("error in register ${error.toString()}");
    });
  }

  var uuid = const Uuid().v4();
  var userUuid = const Uuid().v4();
  final auth = FirebaseAuth.instance;

  void createUsers({
    required String name,
    required String phone,
    required String email,
    required String uid,
    required String img,
  }) async
  {
    emit(CreateUserLoadingState());
    UserModel userModel = UserModel(uid: uid,
        phone: phone,
        email: email,
        name: name,
        img: img,
        bio: '');
    FirebaseFirestore.instance.collection("users").doc(uid).set(
        userModel.toMap()).then((value) {
      emit(CreateUserSuccessState());
      print("***************");
    }).catchError((error) {
      emit(CreateUserErrorState(error: error.toString()));
      print("error in create user ${error.toString()}");
    });
  }

  Future<OAuthCredential> signInWithGoogle(context) async {
    emit(ChatRegisterGoogleLoadingState());
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
    final GoogleSignInAuthentication? googleAuth = await googleUser
        ?.authentication;
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );
    await FirebaseAuth.instance.signInWithCredential(credential).then((value) {
      FirebaseFirestore.instance.collection("users").doc(currentUser?.uid).set({
        "name": googleUser?.email.replaceAll("@gmail.com", ""),
        "uid": googleUser?.id,
        "email": googleUser?.email,
        "phone": "",
        "img": googleUser?.photoUrl,
      });
      emit(ChatRegisterGoogleSuccessState());
    }).catchError((error) {
      emit(ChatRegisterGoogleErrorState(error: error.toString()));
      print("error in signInWithGoogle");
    });
    return credential;
  }






}