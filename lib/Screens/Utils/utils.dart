import 'dart:math';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class Utils{
Size getScreenSize(){
  return MediaQueryData.fromWindow(WidgetsBinding.instance.window).size;
}
 Future <Uint8List?>pickImage() async{
ImagePicker picker = ImagePicker();
 XFile? file =await picker.pickImage(source: ImageSource.gallery);
 
  return file!.readAsBytes();
 
 }

  showSnackBar({required BuildContext context, required String content}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: Colors.orange,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(10),
            topRight: Radius.circular(10),
          ),
        ),
        content: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(content),
          ],
        ),
      ),

    );
  
 }
String getUid(){
  return (100000 + Random().nextInt(10000)).toString();
 }
}