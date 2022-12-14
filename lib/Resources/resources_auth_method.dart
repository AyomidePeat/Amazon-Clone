import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_guide/Resources/cloudFirestoreMethods.dart';

import '../Model/user_details.dart';

class AuthenticationMethods {
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  CloudFireStoreClass cloudFireStoreClass = CloudFireStoreClass();
  Future<String> signUpUser(
      {required String name,
      required String address,
      required String email,
      required String password}) async {
    name.trim();
    address.trim();
    email.trim();
    password.trim();
    String output = "Something went wrong";
    if (name != "" && address != "" && email != "" && password != "") {
//functions
      try {
        await firebaseAuth.createUserWithEmailAndPassword(
            email: email, password: password);
            UserDetailsModel user = UserDetailsModel(name: 'name', address: 'address');
        await cloudFireStoreClass.uploadNameandAddressToDatabase(
            user:user);

        output = "Success";
      } on FirebaseAuthException catch (e) {
        output = e.message.toString();
      }
    } else {
      output = "Please fill up all the fields.";
    }
    return output;
  }

  Future<String> signInUser(
      {required String email, required String password}) async {
    email.trim();
    password.trim();
    String output = "Something went wrong";
    if (email != "" && password != "") {
//functions
      try {
        await firebaseAuth.signInWithEmailAndPassword(
            email: email, password: password);
        output = "Success";
      } on FirebaseAuthException catch (e) {
        output = e.message.toString();
      }
    } else {
      output = "Please fill up all the fields.";
    }
    return output;
  }
}
