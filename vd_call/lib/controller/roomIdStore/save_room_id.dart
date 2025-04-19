import 'package:cloud_firestore/cloud_firestore.dart';

Future<void> saveRoomId(String? roomId)async{
  print("Roomid is null");
  if(roomId==null){
    return;
  }
  try{
    FirebaseFirestore db = FirebaseFirestore.instance;
    var idRef = db.collection('roomIds');
    idRef.doc().set({"id":roomId});
    print("Stored room id in firestore");
  }catch(e){
    print("Error happened while storing the room id");
  }
}