class Msystem {
  ArrayList<Point> points ;
  ArrayList<StopPoint> stopPoints ;
  PVector start;
  Boundary b;

  Msystem(PVector startpoint) {
    start = startpoint.copy();
    points = new ArrayList<Point>();
    points.add(new Point(new PVector(startpoint.x, startpoint.y)));
    stopPoints = new ArrayList<StopPoint>();
  }

  void updatePoint() {

    for (int i = points.size()-1; i >= 0; i--) {
      Point p= points.get(i);
      p.Nextstep();
      String store = p.gen;
      if (p.Dead) {
        points.remove(p);
        StopPoint pp = new StopPoint(p.location);
        pp.gen = store;
        stopPoints.add(pp);
        
      } else if (p.separation == true) {
        PVector formerVelocity = p.velocity.copy();
        PVector formerLocation = p.location.copy();
        points.remove(p);
        StopPoint pp = new StopPoint(p.location);
        pp.gen = store;
        stopPoints.add(pp);
        Point p1 = new Point(formerLocation.copy(), formerVelocity.copy().add(new PVector(random(-0.5, 0.5), random(-0.2, 0.2))));
        p1.gen = store + "a";
        points.add(p1);
        Point p2 =new Point(formerLocation, new PVector(random(-1, 1), random(-1, 1)));
        p2.gen = store + "b";
        points.add(p2);
      }
    }
  }


  void display() {
    for (int i = points.size()-1; i >= 0; i--) {
      Point p = points.get(i);
      p.applyForce(p.DetectBoundary(b));
      p.run();
      p.display();
    }
  }

  void displays() {
    for (int i = stopPoints .size()-1; i >= 0; i--) {
      StopPoint p = stopPoints .get(i);
      p.display();
    }
  }
}
