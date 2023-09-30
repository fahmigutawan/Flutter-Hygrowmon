abstract class MainEvent{}

class OnSelectedNavbarChanged extends MainEvent{
  String route;

  OnSelectedNavbarChanged(this.route);
}