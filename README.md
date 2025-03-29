## Flutter Firebase WebRTC Video Calling App

## Overview

This is a real-time video calling application built using Flutter, Firebase, and WebRTC. It allows users to initiate and receive video calls seamlessly over the internet.

## Features

One-to-one video calling

Real-time signaling using Firebase Firestore

WebRTC for media streaming

Camera and microphone access

Call status updates

## Technologies Used

Flutter

Firebase Firestore (for signaling)

WebRTC (for peer-to-peer communication)

## Prerequisites

Ensure you have the following installed:

Flutter SDK (latest version)

Dart

Firebase account

Android Studio or VS Code (for development)

## Setup Instructions

<h3> Clone the Repository</h3>

git clone https://github.com/your-repo/flutter-webrtc-video-call.git
cd flutter-webrtc-video-call

<h3>Install Dependencies</h3>

```flutter pub get```

<h3>Configure Firebase</h3>

- Create a Firebase project in the Firebase Console

- Enable Firestore Database

- Download the google-services.json (for Android) and GoogleService-Info.plist (for iOS)

- Place them in the respective platform directories.

<h3>Run the App</h3>

```flutter run```

## How It Works

User A generates a unique call ID and shares it with User B.

User B enters the call ID to join the call.

Firebase Firestore manages the signaling for establishing the WebRTC connection.

The WebRTC connection enables peer-to-peer media streaming.

Users can end the call at any time.

## Future Improvements

Group video calls

Screen sharing

Call recording

Improved UI/UX

## Troubleshooting

Ensure you have set up Firebase correctly.

Check for required permissions (camera and microphone).

If running on iOS, enable camera/microphone access in Info.plist.

## Contributors

Prakash Pratap singh 
<a href="https://github.com/Prakash251299" target="blank"><img align="center" src="https://img.shields.io/badge/GitHub-000?logo=github&logoColor=white" alt="https://github.com/Prakash251299" height="30"  /></a>
