import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hygrowmon/data/repository/repository.dart';
import 'package:flutter_hygrowmon/presentation/monitoring/bloc/monitoring_event.dart';
import 'package:flutter_hygrowmon/presentation/monitoring/bloc/monitoring_state.dart';

import '../../../di/injection.dart';

class MonitoringBloc extends Bloc<MonitoringEvent, MonitoringState>{
  final repo = locator.get<Repository>();
  String _tempData = "0";
  String _humData = "0";
  
  StreamController<String> _tempDataController = StreamController();
  StreamSink<String> get _tempDataSink => _tempDataController.sink;
  Stream<String> get tempDataStream => _tempDataController.stream;

  StreamController<String> _humDataController = StreamController();
  StreamSink<String> get _humDataSink => _humDataController.sink;
  Stream<String> get humDataStream => _humDataController.stream;

  MonitoringBloc(super.initialState){
    on<SubscribeTempMonitoring>((event, emit) {
      repo.subscribeMqttTopicTemp((p0){
        _tempData = p0;

        _tempDataSink.add(_tempData);
      });
    });

    on<SubscribeHumMonitoring>((event, emit){
      repo.subscribeMqttTopicHum((p0){
        _humData = p0;

        _humDataSink.add(_humData);
      });
    });
  }
}