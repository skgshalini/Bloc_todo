import 'package:flutter_bloc/flutter_bloc.dart';

class CheckboxCubit extends Cubit<bool> {
  CheckboxCubit(bool i) : super(false);
  void navigate(bool val) => emit(val);
}
