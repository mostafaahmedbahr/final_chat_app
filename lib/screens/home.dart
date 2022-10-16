import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_chat_app_using_firebase_with_more_things/bloc/cubit.dart';
import 'package:new_chat_app_using_firebase_with_more_things/bloc/states.dart';
import 'package:new_chat_app_using_firebase_with_more_things/screens/auth/register/cubit_register/cubit_register.dart';
import 'package:new_chat_app_using_firebase_with_more_things/screens/auth/register/register_screen.dart';
import 'package:new_chat_app_using_firebase_with_more_things/screens/chat_screen/chat_screen.dart';
import 'drawer_screens/my_profile_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _advancedDrawerController = AdvancedDrawerController();

  void _handleMenuButtonPressed() {
    _advancedDrawerController.showDrawer();
  }

  // @override
  // void initState() {
  //   ChatCubit.get(context).getAllUsers();
  //   ChatCubit.get(context).getCurrentUserData();
  //   super.initState();
  // }
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ChatCubit, ChatStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = ChatCubit.get(context);
         return AdvancedDrawer(
          backdropColor: Colors.grey[300],
          controller: _advancedDrawerController,
          animationCurve: Curves.easeInOut,
          animationDuration: const Duration(milliseconds: 300),
          animateChildDecoration: true,
          rtlOpening: false,
          // openScale: 1.0,
          disabledGestures: false,
          childDecoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(16)),
          ),

          child: Scaffold(
            appBar: AppBar(
              backgroundColor: Theme.of(context).scaffoldBackgroundColor,
              title: const Text(
                'Home',
                style: TextStyle(
                  color: Colors.deepOrange,
                ),
              ),
              leading: IconButton(
                onPressed: _handleMenuButtonPressed,
                icon: ValueListenableBuilder<AdvancedDrawerValue>(
                  valueListenable: _advancedDrawerController,
                  builder: (_, value, __) {
                    return AnimatedSwitcher(
                      duration: const Duration(milliseconds: 250),
                      child: Icon(
                        value.visible ? Icons.clear : Icons.menu,
                        key: ValueKey<bool>(value.visible),
                        color: Colors.black87,
                      ),
                    );
                  },
                ),
              ),
            ),

            // body: StreamBuilder<dynamic>(
            //   stream: FirebaseFirestore.instance.collection("users")
            //       .where("uid",isNotEqualTo: cubit.currentUser?.uid).snapshots(),
            //   builder: (context,snapShot)
            //   {
            //     if(snapShot.hasError)
            //     {
            //       return const Text("some thing is error");
            //     }
            //     if(snapShot.connectionState == ConnectionState.waiting)
            //     {
            //       return const Center(
            //         child: CircularProgressIndicator(
            //           color: Colors.deepOrange,
            //         ),
            //       );
            //     }
            //    if(snapShot.hasData)
            //    {
            //      return ListView.builder(
            //          itemCount: snapShot.data?.docs.length,
            //          itemBuilder: (context, index) {
            //            return
            //              // snapShot.data.docs[index].data()['uid']  == cubit.currentUser?.uid ? Container():
            //              Padding(
            //                padding: const EdgeInsets.all(10),
            //                child: Card(
            //                  child: ListTile(
            //                    onTap: () {
            //                      Navigator.push(context,
            //                          MaterialPageRoute(builder: (context) {
            //                            return   ChatScreen(
            //                              userName:
            //                              "${snapShot.data.docs[index].data()['name']}",
            //                              userId:
            //                              "${snapShot.data.docs[index].data()['uid']}",
            //                              userImage:
            //                              "${snapShot.data.docs[index].data()['img']}",
            //                            );
            //                          }));
            //                    },
            //                    contentPadding: const EdgeInsets.symmetric(
            //                        horizontal: 20, vertical: 10),
            //                    leading: Container(
            //                      padding: const EdgeInsets.only(right: 20),
            //                      decoration: const BoxDecoration(
            //                          border: Border(
            //                            right: BorderSide(width: 1),
            //                          )),
            //                      child: CircleAvatar(
            //                        //https://media.istockphoto.com/vectors/load-completed-progress-icon-isolated-on-white-background-vector-vector-id949850430?k=20&m=949850430&s=612x612&w=0&h=PZT7T3HhbT0Eq1O7qnBGLZ4xoyPWGjxXLYhGyVaNEjU=
            //                        radius: 20,
            //                        backgroundColor: Colors.transparent,
            //                        child: snapShot.data.docs[index].data()['img'] == "" ?  Image.network(
            //                          'https://t3.ftcdn.net/jpg/01/83/55/76/240_F_183557656_DRcvOesmfDl5BIyhPKrcWANFKy2964i9.jpg',
            //                          fit: BoxFit.cover,
            //                        ) : Image.network("${snapShot.data.docs[index].data()['img']}"),
            //                      ),
            //                    ),
            //                    title: Text(
            //                      //snapShot.data.docs[index].data()['name']
            //                      "${snapShot.data.docs[index].data()['name']}",
            //                      maxLines: 1,
            //                      overflow: TextOverflow.ellipsis,
            //                      style: const TextStyle(
            //                        fontWeight: FontWeight.bold,
            //                      ),
            //                    ),
            //                  ),
            //                ),
            //              );
            //          });
            //
            //    }
            //    return const Text("");
            //   },
            //
            // ),
            // body: FutureBuilder(
            //   future: cubit.getCurrentUser2(),
            //   builder: (context,snapShot)
            //   {
            //     if(snapShot.hasData)
            //     {
            //       return Text("");
            //     }
            //     if(snapShot.hasError)
            //     {
            //       return const Text("Some Thing error");
            //     }
            //     if(snapShot.connectionState == ConnectionState.waiting)
            //     {
            //       return const Center(
            //         child: CircularProgressIndicator(
            //           color: Colors.deepOrange,
            //         ),
            //       );
            //     }
            //     return const Text("");
            //   },
            // ),

            body: ConditionalBuilder(
              condition:cubit.allUsers.isNotEmpty ,
              fallback:(context)=>const Center(
                child: CircularProgressIndicator(
                  color: Colors.deepOrange,
                ),
              ) ,
              builder: (context)
              {
                return StreamBuilder<dynamic>(
                  stream: FirebaseFirestore.instance.collection("users")
                      .where("uid",isNotEqualTo: "${cubit.currentUser?.uid}").snapshots(),
                  builder: (context,snapShot)
                  {
                    if(snapShot.hasData)
                    {
                      return ListView.builder(
                        itemCount: snapShot.data.docs.length,
                        itemBuilder: (context,index)
                        {
                          return Column(
                            children: [
                              ListTile(
                                trailing: IconButton(
                                  onPressed: (){

                                  },
                                  icon: const Icon(Icons.delete),
                                ),
                                onTap: (){},
                                title: Text("${snapShot.data.docs[index]["name"]}"),
                                subtitle: Text("${snapShot.data.docs[index].id}"),

                              ),
                              // TextFormField(
                              //   onChanged: (name)
                              //   {
                              //     setState(() {
                              //       newName = name;
                              //     });
                              //   },
                              // ),
                              // ElevatedButton(onPressed: (){
                              //
                              //   setState(() {
                              //     testUpdateData("${snapShot.data.docs[index].id}", newName);
                              //   });
                              // },
                              //   child: Text("update"),
                              // ),
                            ],
                          );
                        },
                      );
                    }
                    return Text("");
                  },
                );
              },

            ),
          ),
          drawer:  Drawer(
            child: SafeArea(
              child: ListTileTheme(
                textColor: Colors.black87,
                iconColor: Colors.black87,
                child: Column(mainAxisSize: MainAxisSize.max, children: [
                  Column(
                    children: [
                      Container(
                        width: 128.0,
                        height: 128.0,
                        margin: const EdgeInsets.only(
                          top: 24.0,
                          bottom: 20.0,
                        ),
                        clipBehavior: Clip.antiAlias,
                        decoration: const BoxDecoration(
                          color: Colors.black26,
                          shape: BoxShape.circle,
                        ),
                        child: cubit.currentUser?.photoURL == null
                            ? Image.network(
                          'https://t3.ftcdn.net/jpg/01/83/55/76/240_F_183557656_DRcvOesmfDl5BIyhPKrcWANFKy2964i9.jpg',
                          fit: BoxFit.cover,
                        )
                            : Image.network(
                          '${cubit.currentUser!.photoURL}',
                          fit: BoxFit.cover,
                        ),
                      ),
                      Text(
                        "",
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.red,
                        ),
                      ),
                      const Text(
                          "flutter developer at eraa soft campany"),
                    ],
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  ListTile(
                    onTap: () {
                      Navigator.pushReplacement(context,
                          MaterialPageRoute(builder: (context) {
                            return const HomeScreen();
                          }));
                    },
                    leading: const Icon(CupertinoIcons.person_2_fill),
                    title: const Text('All Users'),
                  ),
                  ListTile(
                    onTap: () {
                      // Navigator.push(context,
                      //     MaterialPageRoute(builder: (context) {
                      //       return MyProfileScreen(
                      //
                      //
                      //       );
                      //     }));
                    },
                    leading: const Icon(Icons.settings_outlined),
                    title: const Text('My Account'),
                  ),
                  const Divider(
                    thickness: 1,
                  ),
                  ListTile(
                    onTap: () {
                      showDialog(
                        // عشان لما اضغط على اى حاجه خارجه ميقفلوش
                          barrierDismissible: false,
                          // اغير لون الخلفية
                          // barrierColor: Colors.red,
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: Row(
                                children: const [
                                  Icon(
                                    Icons.logout_outlined,
                                    color: Colors.lightBlue,
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    "Sign Out",
                                    style: TextStyle(
                                      fontSize: 16,
                                    ),
                                  ),
                                ],
                              ),
                              content: const Text(
                                "Do You Want to sign out ?",
                                style: TextStyle(
                                  fontStyle: FontStyle.italic,
                                ),
                              ),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: const Text("Cancel"),
                                ),
                                TextButton(
                                  onPressed: () async {
                                    // await FirebaseAuth.instance.signOut();
                                    // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)
                                    // {
                                    //   return   LoginScreen();
                                    // }));
                                    cubit.logout(context);

                                  },
                                  child: const Text(
                                    "Ok",
                                    style: TextStyle(color: Colors.pink),
                                  ),
                                ),
                              ],
                            );
                          });
                    },
                    leading: const Icon(Icons.logout_outlined),
                    title: const Text('Log Out'),
                  ),
                ]),
              ),
            ),
          ),
        );
      },
    );
  }
}
