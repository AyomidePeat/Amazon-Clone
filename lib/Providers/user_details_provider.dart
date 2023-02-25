import 'package:flutter/material.dart';
import 'package:flutter_guide/Model/user_details.dart';
import 'package:flutter_guide/Resources/cloudFirestoreMethods.dart';
class  UserDetailsProvider with ChangeNotifier{

 UserDetailsModel userDetails; 

 
  UserDetailsProvider() : userDetails= UserDetailsModel(name: "Loading", address: "Loading");

  Future getData()async{
    userDetails = await CloudFireStoreClass().getNameAndAddress();
    notifyListeners();
  }
}