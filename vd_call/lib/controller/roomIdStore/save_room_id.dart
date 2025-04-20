import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> saveRoomId(String? roomId)async{
  print("Roomid is null");
  if(roomId==null){
    return;
  }
  try{
    FirebaseFirestore db = FirebaseFirestore.instance;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? email = await prefs.getString("email");
    var idRef = db.collection('roomIds');
    idRef.doc(email).set({"id":roomId});
    print("Stored room id in firestore");
  }catch(e){
    print("Error happened while storing the room id");
  }
}