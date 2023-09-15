import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hygrowmon/data/repository/repository.dart';
import 'package:flutter_hygrowmon/presentation/register/bloc/register_event.dart';
import 'package:flutter_hygrowmon/presentation/register/bloc/register_state.dart';

import '../../../di/injection.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  final repo = locator.get<Repository>();

  RegisterBloc(super.initialState) {
    on<OnRoleDataLoad>((event, emit) async {
      emit(Loading());

      try {
        final res = await repo.getAllRole();

        emit(RoleSuccess(res));
      } catch (e) {
        emit(RoleError(e.toString()));
      }
    });

    on<StartRegister>((event, emit) async {
      emit(Loading());

      try {
        final res = await repo.register(
          event.email,
          event.password,
          event.name,
          event.noTelp,
          event.role_id,
        );

        emit(RegisterSuccess(res));
      } catch (e) {
        emit(RegisterError(e.toString()));
      }
    });
  }
}
