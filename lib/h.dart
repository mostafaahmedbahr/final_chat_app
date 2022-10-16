 import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
  class TestHome extends StatefulWidget {
  const TestHome({Key? key}) : super(key: key);

  @override
  State<TestHome> createState() => _TestHomeState();
}
 testGetAllUsers()async
 {
   var all = await FirebaseFirestore.instance.collection("users").where("name",isNotEqualTo: "bahr").get();
   return all;
 }


 testUpdateData(id,val)async
 {
   FirebaseFirestore.instance.collection("users").doc(id).update({
     "name" : val,
   });
 }

 testDeleteData(id)async
 {
 await  FirebaseFirestore.instance.collection("users").doc(id).delete();
 }
 String? newName;
class _TestHomeState extends State<TestHome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: FutureBuilder(
        future:testGetAllUsers() ,
        builder: (context,dynamic snapShot)
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
                          testDeleteData("${snapShot.data.docs[index].id}");
                          setState(() {

                          });
                        },
                        icon: const Icon(Icons.delete),
                      ),
                      onTap: (){},
                      title: Text("${snapShot.data.docs[index]["name"]}"),
                      subtitle: Text("${snapShot.data.docs[index].id}"),

                    ),
                    TextFormField(
                      onChanged: (name)
                      {
                        setState(() {
                          newName = name;
                        });
                      },
                    ),
                    ElevatedButton(onPressed: (){

                      setState(() {
                        testUpdateData("${snapShot.data.docs[index].id}", newName);
                      });
                    },
                        child: Text("update"),
                    ),
                  ],
                );
              },
            );
          }
          return Text("");
        },
      ),
    );
  }
}
