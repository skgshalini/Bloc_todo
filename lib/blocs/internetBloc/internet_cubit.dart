import 'package:flutter_bloc/flutter_bloc.dart';

class InternetCubit extends Cubit<int> {
  InternetCubit(int i) : super(1);

  void check(int  val) => emit(val);
}