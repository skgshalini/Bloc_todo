import 'package:flutter_bloc/flutter_bloc.dart';

class VideoPlayerCubit extends Cubit<int> {
  VideoPlayerCubit(int val) : super(0);

  void control(int val) => emit(val);
}