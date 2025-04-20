import 'package:cloud_firestore/cloud_firestore.dart';

Future<String>getRoomId(roomIdAdmin)async{
  try{
    FirebaseFirestore db = FirebaseFirestore.instance;
    var idRef = await db.collection('roomIds').doc(roomIdAdmin).get();
    // var snapshot = await idRef.get();
    // String roomId = snapshot.docs[0].data()["id"];
    // var snapshot = await idRef.doc(roomIdAdmin);
    String roomId = idRef["id"];
    print("Fetched room id from firestore");
    print(roomId);
    return roomId;
  }catch(e){
    print("Error happened while fetching the room id");
  }
  return "";
}