abstract class RegisterEvent {}

class OnRoleDataLoad extends RegisterEvent {}

class StartRegister extends RegisterEvent {
  String email;
  String password;
  String name;
  String noTelp;
  String role_id;

  StartRegister(
    this.email,
    this.password,
    this.name,
    this.noTelp,
    this.role_id,
  );
}
