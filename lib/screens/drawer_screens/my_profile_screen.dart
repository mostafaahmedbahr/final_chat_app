//  import 'package:firebase_auth/firebase_auth.dart';
//  import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:new_chat_app_using_firebase_with_more_things/bloc/states.dart';
//
// import '../../bloc/cubit.dart';
//
// class MyProfileScreen extends StatelessWidget {
//   MyProfileScreen({
//     Key? key,
//   }) : super(key: key);
//
//   var c = FirebaseAuth.instance.currentUser;
// var nameCon = TextEditingController();
//   @override
//   Widget build(BuildContext context) {
//     return BlocConsumer<ChatCubit, ChatStates>(
//       listener: (context, state) {},
//       builder: (context, state) {
//         var cubit = ChatCubit.get(context);
//         return Scaffold(
//           backgroundColor: Colors.white,
//           appBar: AppBar(
//             leading: IconButton(
//               onPressed: () {
//                 Navigator.pop(context);
//               },
//               icon: const Icon(
//                 Icons.arrow_back_ios_new,
//                 color: Colors.black,
//               ),
//             ),
//             backgroundColor: Colors.white,
//             elevation: 0,
//             title: const Text(
//               "My Account",
//               style: TextStyle(
//                 color: Colors.black,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//             centerTitle: true,
//           ),
//           body: SingleChildScrollView(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 const SizedBox(height: 40,),
//                 Center(
//                   child: Stack(
//                     alignment: Alignment.bottomRight,
//                     children: [
//                       CircleAvatar(
//                         radius: 72,
//                         backgroundColor: Colors.black,
//                         child: CircleAvatar(
//                           radius: 70,
//                           backgroundImage: cubit.imageFile == null
//                               ? const NetworkImage(
//                             'https://t3.ftcdn.net/jpg/01/83/55/76/240_F_183557656_DRcvOesmfDl5BIyhPKrcWANFKy2964i9.jpg',
//                           )
//                               : FileImage(cubit.imageFile!) as ImageProvider,
//                         ),
//                       ),
//                       // InkWell(
//                       //   onTap: (){
//                       //     cubit.bottomSheet(context);
//                       //   },
//                       //   child: const CircleAvatar(
//                       //     radius: 20,
//                       //     child: Icon(Icons.camera_alt),
//                       //   ),
//                       // ),
//                     ],
//                   ),
//                 ),
//                 const SizedBox(height: 40,),
//                 Padding(
//                   padding: const EdgeInsets.symmetric(horizontal: 10.0),
//                   child: Row(
//                     children: [
//                       const Text("Name",
//                       style: TextStyle(
//                         fontWeight: FontWeight.bold,
//                         fontSize: 20,
//                       ),),
//                       const SizedBox(width: 16,),
//                       Expanded(
//                         child: TextFormField(
//                           controller: nameCon,
//                           decoration: const InputDecoration(
//                             border: OutlineInputBorder(),
//                             enabledBorder: OutlineInputBorder(
//                               borderSide: BorderSide(
//                                 color: Colors.black,
//                               ),
//                             ),
//                             focusedBorder: OutlineInputBorder(
//                               borderSide: BorderSide(
//                                 color: Colors.black,
//                               ),
//                             ),
//                             hintText: "Name",
//
//                           ),
//                         ),
//                       ),
//
//                     ],
//                   ),
//                 ),
//                 const SizedBox(height: 20,),
//                 Padding(
//                   padding: const EdgeInsets.symmetric(horizontal: 10.0),
//                   child: Row(
//                     children: [
//                       const Text("Email",
//                         style: TextStyle(
//                           fontWeight: FontWeight.bold,
//                           fontSize: 20,
//                         ),),
//                       const SizedBox(width: 20,),
//                       Expanded(
//                         child: TextFormField(
//                           initialValue: cubit.userEmail,
//                           decoration: const InputDecoration(
//                             border: OutlineInputBorder(),
//                             enabledBorder: OutlineInputBorder(
//                               borderSide: BorderSide(
//                                 color: Colors.black,
//                               ),
//                             ),
//                             focusedBorder: OutlineInputBorder(
//                               borderSide: BorderSide(
//                                 color: Colors.black,
//                               ),
//                             ),
//                             hintText: "Eamil",
//
//                           ),
//                         ),
//                       ),
//
//                     ],
//                   ),
//                 ),
//                 const SizedBox(height: 20,),
//                 Padding(
//                   padding: const EdgeInsets.symmetric(horizontal: 10.0),
//                   child: Row(
//                     children: [
//                       const Text("Phone",
//                         style: TextStyle(
//                           fontWeight: FontWeight.bold,
//                           fontSize: 20,
//                         ),),
//                       const SizedBox(width: 10,),
//                       Expanded(
//                         child: TextFormField(
//                           initialValue: cubit.userPhone,
//                           decoration: const InputDecoration(
//                             border: OutlineInputBorder(),
//                             enabledBorder: OutlineInputBorder(
//                               borderSide: BorderSide(
//                                 color: Colors.black,
//                               ),
//                             ),
//                             focusedBorder: OutlineInputBorder(
//                               borderSide: BorderSide(
//                                 color: Colors.black,
//                               ),
//                             ),
//                             hintText: "Phone",
//
//                           ),
//                         ),
//                       ),
//
//                     ],
//                   ),
//                 ),
//                 const SizedBox(height: 20,),
//                 Padding(
//                   padding: const EdgeInsets.symmetric(horizontal: 10.0),
//                   child: Row(
//                     children: [
//                       const Text("About",
//                         style: TextStyle(
//                           fontWeight: FontWeight.bold,
//                           fontSize: 20,
//                         ),),
//                       const SizedBox(width: 13,),
//                       Expanded(
//                         child: TextFormField(
//                           maxLines: 3,
//                           initialValue: cubit.userBio,
//                           decoration: const InputDecoration(
//                             border: OutlineInputBorder(),
//                             enabledBorder: OutlineInputBorder(
//                               borderSide: BorderSide(
//                                 color: Colors.black,
//                               ),
//                             ),
//                             focusedBorder: OutlineInputBorder(
//                               borderSide: BorderSide(
//                                 color: Colors.black,
//                               ),
//                             ),
//                             hintText: "Bio",
//
//                           ),
//                         ),
//                       ),
//
//                     ],
//                   ),
//                 ),
//                 const SizedBox(height: 20,),
//                 Padding(
//                   padding: const EdgeInsets.symmetric(horizontal: 10),
//                   child: SizedBox(
//                     width: double.infinity,
//                     height: 45,
//                     child: ElevatedButton(
//                       style: ElevatedButton.styleFrom(
//                         primary: Colors.deepOrange,
//                       ),
//                       onPressed: ()  {
//
//
//                       },
//                         child: const Text("Edit",
//                         style: TextStyle(
//                           fontSize: 25,
//                           fontWeight: FontWeight.bold,
//                         ),),
//                     ),
//                   ),
//                 ),
//
//               ],
//             ),
//           ),
//
//         );
//       },
//     );
//   }
// }
//
