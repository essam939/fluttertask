import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

Future<File> getImageFromCamera() async {
  return await ImagePicker.pickImage(source: ImageSource.camera);
}
Future<File> getImageFromGallery() async {
  return  await ImagePicker.pickImage(source: ImageSource.gallery);
}
// show Alert with Image Picker
Future<File> showAlert(BuildContext context) async {
  return await showModalBottomSheet<File>(
    context: context,
//    barrierDismissible: true, // user must tap button!
    builder: (BuildContext context) {
      return Container(
        height: 120,
        decoration: new BoxDecoration(
            borderRadius: new BorderRadius.only(
                topLeft: const Radius.circular(40.0),
                topRight: const Radius.circular(40.0))),
        //  content: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              InkWell(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Text("Take Photo",style: TextStyle(color:Colors.red,fontWeight: FontWeight.bold,fontSize: 15),)
                  ],
                ),
                onTap: ()async{
                  Navigator.of(context).pop(await getImageFromCamera());
                },
              ),
              Divider(),
              InkWell(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Text("Choose Photo",style: TextStyle(color:Colors.green,fontWeight: FontWeight.bold,fontSize: 15),)
                  ],
                ),
                onTap: ()async{
                  Navigator.of(context).pop(await getImageFromGallery());
                },
              ),
            ],
          ),
        ),
        //  ),
      );
    },
  );
}