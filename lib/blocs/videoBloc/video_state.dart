import 'package:video_player/video_player.dart';

abstract class VideoStates {}

class Init extends VideoStates  {}

class LoadingState extends VideoStates  {}
class ControllerState extends VideoStates  {
  VideoPlayerController controller;
  ControllerState({this.controller});
}
class ErrorState extends VideoStates  {
  String error;
  ErrorState({this.error});
}