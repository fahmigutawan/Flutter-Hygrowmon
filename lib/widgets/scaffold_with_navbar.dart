import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../main/bloc/main_bloc.dart';
import '../main/bloc/main_event.dart';

Widget ScaffoldWithNavbar(
    MainBloc mainBloc, BuildContext context, Widget widget) {
  return Scaffold(
    body: widget,
  );
}
