import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hygrowmon/main/bloc/main_event.dart';
import 'package:flutter_hygrowmon/main/bloc/main_state.dart';
import 'package:flutter_hygrowmon/main/routes.dart';

class MainBloc extends Bloc<MainEvent, MainState>{
  String _selectedNavbarRoute = Routes.Splash;

  StreamController<String> _selectedNavbarRouteController = StreamController();
  StreamSink<String> get _selectedNavbarRouteSink => _selectedNavbarRouteController.sink;
  Stream<String> get selectedNavbarRouteStream => _selectedNavbarRouteController.stream;

  MainBloc(super.initialState){
    _selectedNavbarRouteSink.add(Routes.Splash);

    on<OnSelectedNavbarChanged>((event, emit) {
      _selectedNavbarRoute = event.route;
      _selectedNavbarRouteSink.add(_selectedNavbarRoute);
    });
  }
}