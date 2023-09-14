abstract class LoginEvent{}

class StartLogin extends LoginEvent{
  String email;
  String password;

  StartLogin(this.email, this.password);
}