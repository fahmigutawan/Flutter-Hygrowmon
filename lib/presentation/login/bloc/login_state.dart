import 'package:firebase_auth/firebase_auth.dart';

abstract class LoginState{}

class LoginInitial extends LoginState{}

class LoginLoading extends LoginState{}

class LoginSuccess extends LoginState{
  User user;

  LoginSuccess(this.user);
}

class LoginError extends LoginState{
  String errMessage;

  LoginError(this.errMessage);
}