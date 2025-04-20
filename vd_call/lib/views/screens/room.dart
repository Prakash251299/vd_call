import 'package:flutter/material.dart';
import 'package:flutter_webrtc/flutter_webrtc.dart';

class Room extends StatefulWidget {
  RTCVideoRenderer? _localRenderer;
  RTCVideoRenderer? _remoteRenderer;
  Room(this_localRenderer,this._remoteRenderer);

  @override
  State<Room> createState() => _RoomState();
}

class _RoomState extends State<Room> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(child: RTCVideoView(widget._localRenderer!, mirror: true)),
                    widget._localRenderer!=null?Expanded(child: RTCVideoView(widget._remoteRenderer!)):Text(""),
                  ],
                ),
              ),
            );
  }
}