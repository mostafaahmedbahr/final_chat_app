  import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_chat_app_using_firebase_with_more_things/bloc/cubit.dart';
import 'package:new_chat_app_using_firebase_with_more_things/bloc/states.dart';
import 'package:new_chat_app_using_firebase_with_more_things/model/message_model.dart';
class ChatScreen extends StatelessWidget {
  const ChatScreen({Key? key,
    required this.userName,
    required this.userId,
    required this.userImage,
  }) : super(key: key);
  final String userName;
  final String userId;
  final String userImage;
  @override
  Widget build(BuildContext context) {
    var messageCon = TextEditingController();
    return Builder(
      builder: (context) {
        ChatCubit.get(context).receiveMessage(receiverId: userId);
        return BlocConsumer<ChatCubit,ChatStates>(
          listener: (context,state){},
          builder: (context,state){
            var cubit = ChatCubit.get(context);
            return StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance.collection("messages").snapshots(),
              builder: (context,snapShot)
              {
                return Scaffold(
                  backgroundColor: Colors.black,
                  appBar: AppBar(
                    backgroundColor: Colors.black,
                    title: Row(
                      children: [
                        CircleAvatar(
                          //https://media.istockphoto.com/vectors/load-completed-progress-icon-isolated-on-white-background-vector-vector-id949850430?k=20&m=949850430&s=612x612&w=0&h=PZT7T3HhbT0Eq1O7qnBGLZ4xoyPWGjxXLYhGyVaNEjU=
                          radius: 20,
                          backgroundImage: userImage == ""
                              ? const NetworkImage(
                            'https://t3.ftcdn.net/jpg/01/83/55/76/240_F_183557656_DRcvOesmfDl5BIyhPKrcWANFKy2964i9.jpg',
                          )
                              : NetworkImage(
                              userImage),
                          backgroundColor: Colors.transparent,

                        ),
                        const SizedBox(width: 5,),
                        Text(userName),
                      ],
                    ),

                  ),
                  body:  Column(
                    children: [
                      const SizedBox(
                        height: 16.0,
                      ),

                            Expanded(
                            child: ListView.separated(
                              physics: const BouncingScrollPhysics(),
                              itemBuilder: (context, index)
                              {
                                if(cubit.currentUser?.uid == userId) {
                                  return   UserItem(
                                    messageModel: cubit.messages[index],
                                  );
                                }

                                return   MyItem(
                                  messageModel: cubit.messages[index],
                                );
                              },
                              separatorBuilder: (context, index) =>const SizedBox(
                                height: 16.0,
                              ),
                              itemCount: cubit.messages.length,),
                          ),



                      const  SizedBox(
                        height: 16.0,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child:  Row(
                          children: [
                            Expanded(
                              child: TextFormField(
                                style: const TextStyle(
                                  color: Colors.white,
                                ),
                                controller: messageCon,
                                validator: (value)
                                {
                                  if(value!.isEmpty)
                                  {
                                    return "message is empty";
                                  }
                                },
                                decoration:   InputDecoration(
                                    border:OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(20),
                                      borderSide: const BorderSide(
                                        color: Colors.white,
                                      ),
                                    ),
                                    enabledBorder:    OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(20),
                                        borderSide: const BorderSide(
                                          color: Colors.white,
                                        )
                                    ),
                                    focusedBorder:     OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(20),
                                      borderSide: const BorderSide(
                                        color: Colors.white,
                                      ),
                                    ),
                                    hintText: "Type Message",
                                    hintStyle: const TextStyle(
                                      color: Colors.white,
                                    ),
                                    prefixIcon:  IconButton(
                                      onPressed: (){},
                                      icon: const Icon(Icons.face,
                                        color: Colors.white,),
                                    )
                                ),
                              ),
                            ),
                            const SizedBox(width: 5,),
                            FloatingActionButton(
                              backgroundColor: Colors.deepOrange,
                              onPressed: (){
                                cubit.sendMessage(
                                  receiver: userId,
                                  message: messageCon.text,
                                  dateTime: DateTime.now().toString(),
                                );
                                messageCon.clear();
                              },
                              child: const Icon(Icons.message),),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
             
            );
          },

        );
      }
    );
  }
}


class UserItem extends StatelessWidget {
    UserItem({Key? key,required this.messageModel}) : super(key: key);
  final MessageModel messageModel;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 16.0,
          ),
          child: Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 16.0,
              vertical: 10.0,
            ),
            decoration:   BoxDecoration(
              color: Colors.grey[400],
              borderRadius:const BorderRadiusDirectional.only(
                bottomEnd: Radius.circular(6.0,),
                bottomStart: Radius.circular(6.0,),
                topEnd: Radius.circular(6.0,),
              ),
            ),
            child: Text(
              '${messageModel.message}',
              style: Theme.of(context).textTheme.subtitle2,
            ),
          ),
        ),
      ],
    );
  }
}

class MyItem extends StatelessWidget {
    MyItem({Key? key,required this.messageModel}) : super(key: key);
  final MessageModel messageModel;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 16.0,
          ),
          child: Container(
            padding:const EdgeInsets.symmetric(
              horizontal: 16.0,
              vertical: 10.0,
            ),
            decoration:const BoxDecoration(
              color: Colors.deepOrange,
              borderRadius: BorderRadiusDirectional.only(
                bottomEnd: Radius.circular(6.0,),
                bottomStart: Radius.circular(6.0,),
                topStart: Radius.circular(6.0,),
              ),
            ),
            child: Text(
              '${messageModel.message}',
              style: Theme.of(context).textTheme.subtitle2!.copyWith(
                color: Colors.white,
                height: 1.5,
              ),
            ),
          ),
        ),
      ],
    );
  }
}