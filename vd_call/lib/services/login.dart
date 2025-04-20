import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vd_call/views/screens/homepage.dart';

class LoginPage{ 
  Future<int> getLoginStatus()async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    int? isLoggedIn = await prefs.getInt("isLoggedInd");
    if(isLoggedIn==null){
      return 0;
    }
    return isLoggedIn;
  }

  Future<UserCredential> signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    // Once signed in, return the UserCredential
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }

  Future<int> userExists(email)async{
    // var res = await con.collection('users').get(email);
    // print(res);
    try {
    // Reference to Firestore
    var collection = FirebaseFirestore.instance.collection('users');
    
    // Query to check if a document with email ID exists
    var querySnapshot = await collection.where('email', isEqualTo: email).get();

    // Return true if a document is found, otherwise false
    if(querySnapshot.docs.isNotEmpty==true){
      return 1;
    }
    return 0;
    } catch (e) {
      print("Error checking user existence: $e");
      return 0;
    }
    // return 0;
  }

  // Future<void> requestNotificationPermission() async {
  //   if (await Permission.notification.isDenied) {
  //     await Permission.notification.request();
  //   }
  // }
  
  Future<void> login(context)async {
    try{
      LoginPage _loginController = LoginPage();
      if(await _loginController.getLoginStatus()==0){
        UserCredential? user;
        user = await signInWithGoogle();
        final SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString('username', '${user.user?.displayName}');
        await prefs.setString('imgUrl', '${user.user?.photoURL}');
        await prefs.setString('email', '${user.user?.email}');
        // String isLoggedIn = await prefs.setString();
        // await _readWrite.writeEmail((user.user?.email).toString());
        // store date too in local storage here
        // DateTime now = DateTime.now();
        // String date = '${now.day}/${now.month}/${now.year}';
        // await _readWrite.writeDate(date);
        // await requestNotificationPermission();
        // if(await userExists(user.user?.email)==0){
        //   Navigator.of(context).push(MaterialPageRoute(builder: (context)=>const PickArtistPage()));
        //   return;

        // }
      }
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => MyHomePage()), // Replace with your screen
        (Route<dynamic> route) => false, // This removes all previous routes
      );
      // Navigator.pop(context); // For removing the previous login screen
      // Navigator.of(context).push(MaterialPageRoute(builder: (context)=>const App()));
    }catch(e){
      print("Error happened at logging in $e");
    }
  }
}