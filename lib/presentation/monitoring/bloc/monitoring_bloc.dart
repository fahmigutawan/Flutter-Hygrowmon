import 'dart:async';
import 'dart:ffi';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hygrowmon/data/repository/repository.dart';
import 'package:flutter_hygrowmon/presentation/monitoring/bloc/monitoring_event.dart';
import 'package:flutter_hygrowmon/presentation/monitoring/bloc/monitoring_state.dart';
import 'package:mqtt_client/mqtt_client.dart';

import '../../../di/injection.dart';

class MonitoringBloc extends Bloc<MonitoringEvent, MonitoringState> {
  final repo = locator.get<Repository>();
  List<double> _monitoringData = [.0, .0, .0, .0];
  //urutannya suhu, humidity, tanah, PH
  MqttConnectionState _mqttConnectionState = MqttConnectionState.connecting;

  StreamController<List<double>> _mqttDataController = StreamController();
  StreamSink<List<double>> get _mqttDataSink => _mqttDataController.sink;
  Stream<List<double>> get mqttDataStream => _mqttDataController.stream;

  StreamController<MqttConnectionState> _mqttConnectionStateController = StreamController();
  StreamSink<MqttConnectionState> get _mqttConnectionStateSink => _mqttConnectionStateController.sink;
  Stream<MqttConnectionState> get mqttConnectionStateStream => _mqttConnectionStateController.stream;


  MonitoringBloc(super.initialState) {
    on<SubscribeMonitoring>((event, emit) {
      _mqttDataSink.add(_monitoringData);
      repo.subscribeMqttTopic((p0) {
        final res = p0.split(":").map((e) {
          try {
            final s = double.parse(e);
            return s;
          } catch (e) {
            return .0;
          }
        }).toList();

        _monitoringData = res;

        _mqttDataSink.add(_monitoringData);
      });
    });

    on<ConnectMqtt>((event, emit) async {
      _mqttConnectionStateSink.add(_mqttConnectionState);

      try {
        final res = await repo.connectMqtt();

        _mqttConnectionState = res!.state;
      } on NoConnectionException catch (e) {
        repo.disconnectMqtt();
        _mqttConnectionState = MqttConnectionState.disconnected;
      } on SocketException catch (e) {
        repo.disconnectMqtt();
        _mqttConnectionState = MqttConnectionState.disconnected;
      }

      _mqttConnectionStateSink.add(_mqttConnectionState);
    });
  }
}
