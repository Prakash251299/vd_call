import 'package:cloud_firestore/cloud_firestore.dart';

Future<String>getRoomId()async{
  try{
    FirebaseFirestore db = FirebaseFirestore.instance;
    var idRef = db.collection('roomIds');
    var snapshot = await idRef.get();
    String roomId = snapshot.docs[0].data()["id"];
    print("Fetched room id from firestore");
    print(roomId);
    return roomId;
  }catch(e){
    print("Error happened while fetching the room id");
  }
  return "";
}