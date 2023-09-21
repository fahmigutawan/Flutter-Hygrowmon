import 'package:flutter_hygrowmon/data/repository/repository.dart';
import 'package:flutter_hygrowmon/di/injection.dart';
import 'package:get/get.dart';
import 'package:mqtt_client/mqtt_client.dart';

class MonitoringController extends GetxController {
  final repo = locator.get<Repository>();

  Future<MqttClientConnectionStatus?> connectMqtt() async {
    return await repo.connectMqtt();
  }
}
