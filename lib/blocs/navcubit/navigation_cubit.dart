import 'package:flutter_bloc/flutter_bloc.dart';

class NavigationCubit extends Cubit<int> {
  NavigationCubit(int i) : super(0);

  void navigate(int ind) => emit(ind);
}