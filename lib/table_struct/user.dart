import 'package:cloud_firestore/cloud_firestore.dart';

class UserStruct {
  String uid;
  String email;
  String nama;
  String no_telp;
  String role_id;

  UserStruct(this.uid,
    this.email,
    this.nama,
    this.no_telp,
    this.role_id,
  );

  static UserStruct fromSnapshot(DocumentSnapshot snapshot) {
    return UserStruct(
      snapshot["uid"],
      snapshot["email"],
      snapshot["nama"],
      snapshot["no_telp"],
      snapshot["role_id"],
    );
  }

  Map<String, Object?> toJson() {
    return {
      "uid": this.uid,
      "email": this.email,
      "nama": this.nama,
      "no_telp": this.no_telp,
      "role_id": this.role_id,
    };
  }
}
