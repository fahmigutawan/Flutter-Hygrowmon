import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_hygrowmon/table_struct/role.dart';

abstract class RegisterState{}

class RegisterInitial extends RegisterState{}

class Loading extends RegisterState{}

class RoleSuccess extends RegisterState{
  List<RoleStruct> data;

  RoleSuccess(this.data);
}

class RoleError extends RegisterState{
  String msg;

  RoleError(this.msg);
}

class RegisterSuccess extends RegisterState{
  UserCredential data;

  RegisterSuccess(this.data);
}

class RegisterError extends RegisterState{
  String msg;

  RegisterError(this.msg);
}