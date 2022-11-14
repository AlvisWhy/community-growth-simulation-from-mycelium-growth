class StopPoint {
  PVector location;
  String gen;

  StopPoint(PVector p) {
    location = p;
  }

  void display() {
    ellipse(location.x, location.y, 1, 1);
  }
}
