import 'package:flutter/material.dart';
import 'package:flutter_hygrowmon/presentation/monitoring/bloc/monitoring_bloc.dart';
import 'package:flutter_hygrowmon/presentation/monitoring/bloc/monitoring_event.dart';
import 'package:flutter_hygrowmon/presentation/monitoring/bloc/monitoring_state.dart';
import 'package:flutter_hygrowmon/presentation/monitoring/controller/monitoring_controller.dart';
import 'package:flutter_hygrowmon/presentation/monitoring/screen/widget/monitoring_item.dart';
import 'package:flutter_hygrowmon/widgets/fullscreen_loading.dart';
import 'package:get/get.dart';
import 'package:mqtt_client/mqtt_client.dart';

import '../../../theme_data/AppColor.dart';

class MonitoringScreen extends StatefulWidget {
  const MonitoringScreen({super.key});

  @override
  State<MonitoringScreen> createState() => _MonitoringScreenState();
}

class _MonitoringScreenState extends State<MonitoringScreen> {
  final controller = Get.find<MonitoringController>();
  final bloc = MonitoringBloc(MonitoringInitial());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColor.Green,
        title: Padding(
          child: Text(
            "Agrisolute",
            style: TextStyle(
              fontSize: 34,
              fontFamily: "Crete Round Regular",
            ),
          ),
          padding: EdgeInsets.only(bottom: 32),
        ),
      ),
      body: FutureBuilder(
        future: controller.connectMqtt(),
        builder: (context, snapshotMqttConnection) {
          if (!snapshotMqttConnection.hasData) {
            return FullscreenLoadingBox();
          } else {
            if (snapshotMqttConnection.data?.state !=
                MqttConnectionState.connected) {
              return FullscreenLoadingBox();
            } else {
              bloc.add(SubscribeTempMonitoring());
              return GridView(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3),
                children: [
                  StreamBuilder(
                    stream: bloc.tempDataStream,
                    builder: (context, snapshot) {
                      return Padding(
                        padding: EdgeInsets.all(4),
                        child: MonitoringItem(
                          img: "assets/images/monitoring_suhu.png",
                          data: snapshot.data ?? "...",
                          label: "Suhu",
                        ),
                      );
                    },
                  ),
                  StreamBuilder(
                    stream: bloc.tempDataStream,
                    builder: (context, snapshot) {
                      return Padding(
                        padding: EdgeInsets.all(4),
                        child: MonitoringItem(
                          img: "assets/images/monitoring_kelembaban_tanah.png",
                          data: snapshot.data ?? "...",
                          label: "Kelembapan Tanah",
                        ),
                      );
                    },
                  ),
                  StreamBuilder(
                    stream: bloc.tempDataStream,
                    builder: (context, snapshot) {
                      return Padding(
                        padding: EdgeInsets.all(4),
                        child: MonitoringItem(
                          img: "assets/images/monitoring_ph.png",
                          data: snapshot.data ?? "...",
                          label: "pH Air",
                        ),
                      );
                    },
                  ),
                  StreamBuilder(
                    stream: bloc.tempDataStream,
                    builder: (context, snapshot) {
                      return Padding(
                        padding: EdgeInsets.all(4),
                        child: MonitoringItem(
                          img: "assets/images/monitoring_kelembaban_udara.png",
                          data: snapshot.data ?? "...",
                          label: "Kelembapan Udara",
                        ),
                      );
                    },
                  )
                ],
              );
            }
          }
        },
      ),
    );
  }
}
