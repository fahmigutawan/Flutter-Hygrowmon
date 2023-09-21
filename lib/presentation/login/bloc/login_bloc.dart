import 'package:bloc/bloc.dart';
import 'package:flutter_hygrowmon/data/repository/repository.dart';
import 'package:flutter_hygrowmon/di/injection.dart';
import 'package:flutter_hygrowmon/presentation/login/bloc/login_event.dart';
import 'package:flutter_hygrowmon/presentation/login/bloc/login_state.dart';
import 'package:logger/logger.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  Repository repo = locator.get<Repository>();

  LoginBloc(super.initialState) {
    on<StartLogin>(
      (event, emit) async {
        emit(LoginLoading());
        try {
          final result = await repo.login(event.email, event.password);

          if(result.user != null){
            emit(LoginSuccess(result.user!));
          }
        } catch (e) {
          emit(LoginError(e.toString()));
        }
      },
    );
  }
}
