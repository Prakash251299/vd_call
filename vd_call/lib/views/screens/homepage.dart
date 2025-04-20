import 'package:flutter/material.dart';
import 'package:flutter_webrtc/flutter_webrtc.dart';
import 'package:vd_call/controller/roomIdStore/get_room_id.dart';
import 'package:vd_call/controller/roomIdStore/save_room_id.dart';
import 'package:vd_call/signaling.dart';
import 'package:vd_call/views/screens/room.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Signaling signaling = Signaling();
  RTCVideoRenderer _localRenderer = RTCVideoRenderer();
  RTCVideoRenderer _remoteRenderer = RTCVideoRenderer();
  String? roomId;
  TextEditingController textEditingController = TextEditingController(text: '');

  @override
  void initState() {
    _localRenderer.initialize();
    _remoteRenderer.initialize();

    signaling.onAddRemoteStream = ((stream) {
      _remoteRenderer.srcObject = stream;
      setState(() {});
    });

    super.initState();
  }

  @override
  void dispose() {
    _localRenderer.dispose();
    _remoteRenderer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black12,
      appBar: AppBar(
        backgroundColor: Colors.black12,
        title: Text("Video caller",style: TextStyle(color: Colors.white),),
      ),
      body: Center(
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          // crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 8),
            // SingleChildScrollView(
            //       scrollDirection: Axis.vertical,
            //       child: 
                // ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                
                ElevatedButton(
                  onPressed: ()async {
                    await signaling.openUserMedia(_localRenderer, _remoteRenderer);
                    setState(() {});
                  },
                  child: Text("Open camera & microphone"),
                ),
                SizedBox(
                  width: 8,
                ),
                ElevatedButton(
                  onPressed: () async {
                    roomId = await signaling.createRoom(_remoteRenderer);
                    textEditingController.text = roomId!;
                    await saveRoomId(roomId);
                    setState(() {});
                    Navigator.of(context).push(MaterialPageRoute(builder: (context)=>Room(_localRenderer,_remoteRenderer)));
                  },
                  child: Text("Create room"),
                ),
                SizedBox(
                  width: 8,
                ),
                ElevatedButton(
                  onPressed: () async{
                    // Add roomId
                    // String s = textEditingController.text.trim();
                    String roomId = await getRoomId("prakashpratapsingh6@gmail.com");
                    signaling.joinRoom(
                      roomId,
                      _remoteRenderer,
                    );
                  },
                  child: Text("Join room"),
                ),
                SizedBox(
                  width: 8,
                ),
                GestureDetector(
                  
                  onTap: () {
                    signaling.hangUp(_localRenderer);
                  },
                  child: Container(
                    padding: EdgeInsets.all(7),
                    width: 120,
                    height: 40,
                    decoration: BoxDecoration(
                      borderRadius:BorderRadius.all(Radius.circular(20)), 
                      color: Colors.white
                      
                    ),
                    child: Center(child:Text("Hang up",style: TextStyle(fontSize: 16),))),
                )
              ],
            ),
            // ),
            SizedBox(height: 8),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(child: RTCVideoView(_localRenderer, mirror: true)),
                    Expanded(child: RTCVideoView(_remoteRenderer)),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Join the following Room: ",style: TextStyle(color: Colors.white),),
                  Flexible(
                    child: TextFormField(
                      controller: textEditingController,
                    ),
                  )
                ],
              ),
            ),
            SizedBox(height: 8)
          ],
        ),
      ),
    );
  }
}