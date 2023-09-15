import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hygrowmon/presentation/register/bloc/register_event.dart';
import 'package:flutter_hygrowmon/presentation/register/bloc/register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState>{
  RegisterBloc(super.initialState);
}