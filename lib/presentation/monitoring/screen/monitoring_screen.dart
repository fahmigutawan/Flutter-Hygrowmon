import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
  final bloc = MonitoringBloc(MonitoringInitial())..add(ConnectMqtt());

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
      body: StreamBuilder(
        stream: bloc.mqttConnectionStateStream,
        builder: (context, snapshot){
          if(snapshot.data == null){
            return FullscreenLoadingBox();
          }else{
            if(snapshot.data! == MqttConnectionState.connected){
              bloc.add(SubscribeMonitoring());
              double width = MediaQuery.of(context).size.width;
              return StreamBuilder(
                stream: bloc.mqttDataStream,
                builder: (context, snapshot) {
                  if (snapshot.data == null) {
                    return FullscreenLoadingBox();
                  } else {
                    return GridView(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3),
                      children: [
                        Padding(
                          padding: EdgeInsets.all(2),
                          child: MonitoringItem(
                            width: width/3,
                            img: "assets/images/monitoring_suhu.png",
                            data: snapshot.data![0].toString() ?? "...",
                            label: "Suhu",
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(2),
                          child: MonitoringItem(
                            width: width/3,
                            img:
                            "assets/images/monitoring_kelembaban_udara.png",
                            data: snapshot.data![1].toString() ?? "...",
                            label: "Kelembapan Udara",
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(2),
                          child: MonitoringItem(
                            width: width/3,
                            img:
                            "assets/images/monitoring_kelembaban_tanah.png",
                            data: snapshot.data![2].toString() ?? "...",
                            label: "Kelembapan Air",
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(2),
                          child: MonitoringItem(
                            width: width/3,
                            img: "assets/images/monitoring_ph_air.png",
                            data: snapshot.data![3].toString() ?? "...",
                            label: "PH Air",
                          ),
                        ),
                      ],
                    );
                  }
                },
              );
            }else{
              return Center(
                child: Text("ERROR: Cek kembali koneksi maupun alat anda"),
              );
            }
          }
        },
      )
    );
  }
}
