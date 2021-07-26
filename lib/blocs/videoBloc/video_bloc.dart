import 'package:bloc_todo/blocs/videoBloc/video_events.dart';
import 'package:bloc_todo/blocs/videoBloc/video_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:video_player/video_player.dart';

class VideoBloc extends Bloc<VideoEvents, VideoStates> {
  VideoBloc(VideoStates initialState, VideoEvents VideoEvent)
      : super(initialState);
  VideoPlayerController controller;
  @override
  Stream<VideoStates> mapEventToState(VideoEvents event) async* {
    if (event is PlayVideoEvent) {
      bool _validURL = Uri.parse(event.url).isAbsolute;
      bool _validVideoUrl = event.url.toLowerCase().contains("video");
      if (!_validURL || !_validVideoUrl)
        yield ErrorState(error: "Not a vaild url ");
      else {
        controller = VideoPlayerController.network(event.url);
        yield LoadingState();

        await controller.initialize();
        controller.setLooping(true);
        yield ControllerState(controller: controller);
      }
    }
  }

  void dispose() {
    controller.dispose();
  }
}
//"https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4"
