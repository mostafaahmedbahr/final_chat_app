import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:paginate_firestore/paginate_firestore.dart';

class Pagi extends StatefulWidget {
  const Pagi({Key? key}) : super(key: key);

  @override
  State<Pagi> createState() => _PagiState();
}

class _PagiState extends State<Pagi> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: PaginateFirestore(
        itemBuilder: (context,dynamic ds , index){
          return ListTile(
            title: Text("${ds[index]["name"]}"),
            subtitle: Text("${ds[index].id}"),
          );
          } ,
        itemBuilderType: PaginateBuilderType.listView,
        query: FirebaseFirestore.instance.collection("users").where("name",isEqualTo: "bahr"),
      ),
    );
  }
}
