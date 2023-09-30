import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../main/bloc/main_bloc.dart';
import '../main/bloc/main_event.dart';
import 'navbar.dart';

Widget ScaffoldWithNavbar(MainBloc mainBloc, BuildContext context, Widget widget) {
  return Scaffold(
    bottomNavigationBar: StreamBuilder(
      stream: mainBloc.selectedNavbarRouteStream,
      builder: (_, snapshot) {
        if (snapshot.hasData) {
          debugPrint(snapshot.data.toString());
          return AppNavbar(
            snapshot.data ?? "/",
            (route, index) {
              mainBloc.add(OnSelectedNavbarChanged(route));
              context.push(route);
            },
          );
        } else {
          return Container();
        }
      },
    ),
    body: widget,
  );
}
