import 'package:cloud_firestore/cloud_firestore.dart';

class RoleStruct {
  String role_id;
  String word;

  RoleStruct(this.role_id, this.word);

  static RoleStruct fromSnapshot(DocumentSnapshot snapshot) {
    return RoleStruct(
      snapshot.get("role_id"),
      snapshot.get("word"),
    );
  }
}
