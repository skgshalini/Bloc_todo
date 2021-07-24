abstract class VideoEvents {}
class Eve extends VideoEvents  {}
class PlayVideoEvent extends VideoEvents {
  String url;
  PlayVideoEvent({this.url});
}