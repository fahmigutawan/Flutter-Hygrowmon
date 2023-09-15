import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_hygrowmon/table_struct/role.dart';
import 'package:flutter_hygrowmon/table_struct/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../di/injection.dart';

class Repository {
  final SharedPreferences pref = locator.get<SharedPreferences>();
  final FirebaseAuth auth = FirebaseAuth.instance;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  bool isLogin() {
    return auth.currentUser != null;
  }

  void saveFirstTimeState(bool state) {
    pref.setBool("first_time", state);
  }

  bool getFirstTimeState() {
    return pref.getBool("first_time") ?? true;
  }

  Future<UserCredential> login(String email, String password) async {
    return await auth.signInWithEmailAndPassword(
        email: email, password: password);
  }

  Future<List<RoleStruct>> getAllRole() async {
    return await firestore.collection("role").get().then(
      (QuerySnapshot value) {
        return value.docs
            .map((DocumentSnapshot e) => RoleStruct.fromSnapshot(e))
            .toList();
      },
    );
  }

  Future<UserCredential> register(
    String email,
    String password,
    String nama,
    String no_telp,
    String role_id,
  ) async {
    return await auth
        .createUserWithEmailAndPassword(email: email, password: password)
        .then(
      (UserCredential cred) async {
        return await firestore
            .collection("user")
            .add(
              UserStruct(
                cred.user?.uid ?? "",
                email,
                nama,
                no_telp,
                role_id,
              ).toJson(),
            )
            .then((value) => cred)
        .catchError((e) async {
          await cred.user?.delete();

          throw Exception("Registrasi gagal, coba lagi nanti");
        });
      },
    );
  }
}
