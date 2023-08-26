import 'package:flutter_hygrowmon/di/injection/injection.config.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

final getIt = GetIt.instance;

@injectableInit
Future<void> configureDependencies() async {
  getIt.init();
  await getIt.allReady();
}