import 'dart:io';

import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
final StorageReference storageReference = FirebaseStorage().ref();
final FirebaseDatabase mDatabaseReference=FirebaseDatabase.instance;
class MainProvider with ChangeNotifier {
  Color mainColor = Color(0xffb2dfdb);
  Color secondColor=Color(0xff39796b);
  uploadData(var userId,List data,File userImage){
     mDatabaseReference.reference().child("user").child(userId).set(data);
     storageReference.child(userId).putFile(userImage);

   }
  List getData(var userId){
    List userdata=[];
   mDatabaseReference.reference().child("user").child(userId).once().then((res){
    userdata.add(res.value[0].toString());});
   storageReference.child(userId).getDownloadURL().then((res){userdata.add(res);});
   return userdata;
   }

}