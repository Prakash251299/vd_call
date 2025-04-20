import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
// import 'package:vd_call/controller/roomIdStore/get_room_id.dart';
// import 'package:vd_call/controller/roomIdStore/save_room_id.dart';
import 'package:vd_call/firebase_options.dart';
import 'package:vd_call/services/login.dart';
// import 'package:flutter_webrtc/flutter_webrtc.dart';
// import 'package:vd_call/signaling.dart';
import 'package:vd_call/views/screens/homepage.dart';
import 'package:vd_call/views/screens/login_screen.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
  );
  // await Firebase.initializeApp();
//   await Firebase.initializeApp(
//     options: DefaultFirebaseOptions.currentPlatform
// );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    LoginPage loginController = LoginPage();
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: FutureBuilder(future: loginController.getLoginStatus(), 
        builder: (BuildContext context, snapshot) {
          print('main is fine');
          print(snapshot.data);
            if (!snapshot.hasData) {
              // while data is loading:
              return Center(
                child: CircularProgressIndicator(),
              );
            } else {
              // data loaded:
              
              final status = snapshot.data;
              print("LoginStatus: $status");
              // status=1 means user is installed the app already and data is fetched
              // status=0 mwans either user is new or has unintalled the app
              return status==1?MyHomePage():LoginScreen();
            }
          },
        ),
    );
  }
}