import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_hygrowmon/data/repository/repository.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:mqtt_client/mqtt_client.dart';
import 'package:mqtt_client/mqtt_server_client.dart';
import 'package:shared_preferences/shared_preferences.dart';

final locator = GetIt.instance;

Future<void> configureDependencies() async {
  locator.registerSingletonAsync<SharedPreferences>(
    () => SharedPreferences.getInstance(),
  );
  locator.registerSingleton<MqttServerClient>(
    MqttServerClient.withPort(
      dotenv.env["MQTT_SERVER"] ?? "",
      dotenv.env["MQTT_CLIENT_ID"] ?? "",
      int.parse(dotenv.env["MQTT_PORT"] ?? "80"),
    )
      ..setProtocolV311()
      ..keepAlivePeriod = 20
      ..logging(on: false)
      ..onConnected = () {
        debugPrint("CONNECTED");
      }
      ..onDisconnected = () {
        debugPrint("DISCONNECTED");
      },
  );
  locator.registerSingletonWithDependencies(
    () => Repository(),
    dependsOn: [SharedPreferences],
  );
}
