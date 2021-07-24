import 'package:bloc_todo/blocs/videoBloc/video_bloc.dart';
import 'package:bloc_todo/blocs/videoBloc/video_events.dart';
import 'package:bloc_todo/blocs/videoBloc/video_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:video_player/video_player.dart';
import 'package:bloc_todo/blocs/videoplayerCubit/videoplayer_cubit.dart';
class VideoPLayer extends StatefulWidget {
  String url;

  VideoPLayer({this.url});
  @override
  _VideoPLayerState createState() => _VideoPLayerState();
}

class _VideoPLayerState extends State<VideoPLayer> {
  @override
  void initState() {
    BlocProvider.of<VideoBloc>(context).add(
        PlayVideoEvent(url: widget.url));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<VideoPlayerCubit>(
        create: (context) => VideoPlayerCubit(0),
    child:  Scaffold(
        appBar: AppBar(title: Text("Video")),
        body: BlocBuilder<VideoBloc, VideoStates>(
            builder: (context, state) {
              if (state is LoadingState) {
                return Center(child: CircularProgressIndicator());
              }
              else if (state is ControllerState) {
                return Column(
                  children: [
                    Center(
                      child: AspectRatio(
                        aspectRatio: state.controller.value.aspectRatio,
                        child: VideoPlayer(state.controller),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: (){

                          if (state.controller.value.isPlaying) {
                            state.controller.pause();
                            context.read<VideoPlayerCubit>().control(0);
                          } else {
                            state.controller.play();
                            context.read<VideoPlayerCubit>().control(1);
                          }

                      },
                      child:  BlocBuilder<VideoPlayerCubit, int>(builder: (context, val) {
              return Icon(state.controller.value.isPlaying ? Icons.pause : Icons.play_arrow);
              },),
                    ),
                  ],
                );
              }
              else if (state is ErrorState)
                return Center(child: Text(state.error,style: TextStyle(fontSize:24,fontWeight: FontWeight.bold)));
              return Container();
            }
        ),

      ),
    );

  }
}
