 import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
 import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:new_chat_app_using_firebase_with_more_things/bloc/states.dart';
import 'package:new_chat_app_using_firebase_with_more_things/core/utile/nav.dart';
import 'package:new_chat_app_using_firebase_with_more_things/model/message_model.dart';
import 'package:new_chat_app_using_firebase_with_more_things/model/user_model.dart';
import 'package:new_chat_app_using_firebase_with_more_things/screens/auth/login/cubit_login/states.dart';
import 'package:new_chat_app_using_firebase_with_more_things/screens/auth/login/login_screen.dart';
import 'dart:io';
import 'package:path/path.dart';
class ChatCubit extends Cubit<ChatStates>
{
  ChatCubit() : super(ChatInitialState());

  static ChatCubit get(context) => BlocProvider.of(context);
  var currentUser = FirebaseAuth.instance.currentUser;

  void logout(context)async
  {
    emit(ChatLogoutLoadingState());
    FirebaseAuth.instance.signOut().then((value)
    {

      emit(ChatLogoutSuccessState());
       AppNav.customNavigator(
          context: context,
          screen: LoginScreen(),
          finish: true,
      );
       print(userId);
      print("success");
    }).catchError((error)
    {
      emit(ChatLogoutErrorState());
      print("error in login ${error.toString()}");
    });
  }





  var ueresRef = FirebaseFirestore.instance.collection("users");
  String? userName ;
  String ? userEmail;
  String? userId;
  String? userImg;
  String? userPhone;
String? userBio;

  getCurrentUserData()async
  {
    var currentUser = FirebaseAuth.instance.currentUser;
    print(currentUser);
    var usersRef = await FirebaseFirestore.instance.collection("users").doc("${currentUser?.uid}").get();
    userName = usersRef.get("name");
    userEmail = usersRef.get("email");
    userId = usersRef.get("uid");
    userImg = usersRef.get("img");
    userPhone = usersRef.get("phone");
    userBio = usersRef.get("bio");
    print(userName);
    print("-----------");
    print(userEmail);
    print("-----------");
    print(userImg);
    print("-----------");
    print(userBio);
    print("-----------");
    print(userPhone);
    print("-----------");
  }
  getCurrentUser2()async
  {
    return FirebaseAuth.instance.currentUser;
  }



  File? imageFile;
  final ImagePicker picker = ImagePicker();
  Reference? ref;
  Future<void> takePhoto(ImageSource source)async
  {
    final pickedFile2 = await picker.pickImage(
      source: source,imageQuality: 50,maxWidth: 150,maxHeight: 150,
    );
    imageFile = File(pickedFile2!.path);
    await ref?.putFile(imageFile!);
    emit(ChangePhotoState());
  }

  bottomSheet(ctx)
  {
    return showModalBottomSheet(
      context: ctx,
      builder: (ctx)
      {
        return Container(
          padding: const EdgeInsets.all(20),
          height: 180,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Choose Profile Photo",
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
              ),
              InkWell(
                onTap: ()
                {
                  takePhoto(ImageSource.gallery);
                  var rand = Random().nextInt(1000000);
                  var imageName = "$rand" +  "jpg";
                  ref = FirebaseStorage.instance.ref("images").child(imageName);
                  Navigator.of(ctx).pop();
                },
                child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(10),
                    child: Row(
                      children: const [
                        Icon(
                          Icons.photo_outlined,
                          size: 30,
                        ),
                        SizedBox(width: 20),
                        Text(
                          "From Gallery",
                          style: TextStyle(fontSize: 20),
                        )
                      ],
                    )),
              ),
              InkWell(
                onTap: ()
                {
                  var rand = Random().nextInt(1000000);
                  var imageName = "$rand" +  "jpg";
                  takePhoto(ImageSource.camera);
                  ref = FirebaseStorage.instance.ref("images").child(imageName);
                  Navigator.of(ctx).pop();
                },
                child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(10),
                    child: Row(
                      children: const [
                        Icon(
                          Icons.camera_alt,
                          size: 30,
                        ),
                        SizedBox(width: 20),
                        Text(
                          "From Camera",
                          style: TextStyle(fontSize: 20),
                        )
                      ],
                    )),
              ),

            ],
          ),
        );
      },
    );
  }
  GlobalKey<FormState> formKey =   GlobalKey<FormState>();
  var nameCon = TextEditingController();
  Future updateUserData(String name)async
  {
    var formData = formKey.currentState;
    emit(UpdateUserDateLoadingState());
    formData?.save();
   await FirebaseFirestore.instance.collection("users").doc(currentUser?.uid).update(
        {
          "bio" : userBio ,
          "email" : userEmail,
          "img" : imageFile,
          "phone" : userPhone,
          "name" : name,
        }).then((value)
    {
      emit(UpdateUserDateSuccessState());
    }).catchError((error)
    {
      print("error in update ${error.toString()}");
      emit(UpdateUserDateErrorState());
    });
  }

List<UserModel> allUsers = [];
  UserModel? userModel;
  getAllUsers()
  {
    emit(GetAllUsersLoadingState());
    FirebaseFirestore.instance.collection("users").get().then((value)
    {
      for (var element in value.docs) {
        if(element.data()["uid"] != currentUser?.uid) {
          allUsers.add(UserModel.fromJson(element.data()));
        }
      }
      emit(GetAllUsersSuccessState());
    }).catchError((error)
    {
      print("error in get all users ${error.toString()}");
      emit(GetAllUsersErrorState());
    });
  }

  getAllUsers222()
  {
    emit(GetAllUsersLoadingState());

    FirebaseFirestore.instance.collection("users").where("uid",isNotEqualTo: currentUser?.uid)
        .snapshots().listen((event) {
      for (var element in event.docs) {
        allUsers.add(UserModel.fromJson(element.data()));
      }
    });
  }

  // testGetAllUsers()async
  // {
  //   var all = await FirebaseFirestore.instance.collection("users").get();
  //   return all;
  // }
  testGetAllUsers()async
  {
    var all = await FirebaseFirestore.instance.collection("users")
        .where("uid",isNotEqualTo: "bahr").get();
    return all;
  }


  MessageModel? messageModel;
  sendMessage({required String receiver, required String message ,required String dateTime})
  {
     messageModel = MessageModel(
      dateTime: dateTime,
      message: message,
      receiverId: receiver,
      senderId: currentUser?.uid,
    );
    FirebaseFirestore.instance.collection("users")
        .doc(currentUser?.uid).
    collection("chats").
    doc(receiver).
    collection("messages").add(messageModel!.toMap()).then((value)
    {
      print("-----------");
      print(messageModel!.message);
      emit(SendMessageSuccessState());
    }).catchError((error)
    {
      emit(SendMessageErrorState());
      print("error in send message ${error.toString()}");
    });
    // عشان الداتا تتحفظ عندى وعنده
    FirebaseFirestore.instance.collection("users")
        .doc(receiver).
    collection("chats").
    doc(currentUser?.uid).
    collection("messages").add(messageModel!.toMap()).then((value)
    {
      print("-----------");
      print(messageModel!.message);
      emit(SendMessageSuccessState());
    }).catchError((error)
    {
      emit(SendMessageErrorState());
      print("error in send message ${error.toString()}");
    });
  }

List messages = [];
  receiveMessage({required String receiverId})
  {
    FirebaseFirestore.instance.collection("users")
        .doc(currentUser?.uid)
    .collection("chats")
    .doc(receiverId)
        .collection("messages").orderBy("dateTime").snapshots().listen((event) {
          // لازم اصفر القايمة عشان هو بيعمل double للرسايل
        messages = [];
        for (var element in event.docs) {
          messages.add(MessageModel.fromJson(element.data()));
        }
    });
    emit(ReceiveMessageSuccessState());
  }


  // testUpdateUserData()
  // {
  //   FirebaseAuth.instance.currentUser?.updateDisplayName(nameCon.text);
  // }
}






