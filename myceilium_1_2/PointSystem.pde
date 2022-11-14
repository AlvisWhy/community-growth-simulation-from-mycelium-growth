class Msystem {
  ArrayList<Point> points ;
  ArrayList<StopPoint> stopPoints ;
  PVector start;

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
      if (p.isDead()) {
        points.remove(p);
        stopPoints.add(new StopPoint(p.location));
      } 
      
      else if (p.separation == true) {
        PVector formerVelocity = p.velocity.copy();
        PVector formerLocation = p.location.copy();
        points.remove(p);
        points.add(new Point(formerLocation.copy(), formerVelocity.copy().add(new PVector(random(-0.5, 0.5), random(-0.2, 0.2)))));
        points.add(new Point(formerLocation, new PVector(random(-1, 1), random(-1, 1))));
      }
    }
  }


  void display() {
    for (int i = points.size()-1; i >= 0; i--) {
      Point p = points.get(i);
      p.run();
      p.display();
      println(points.size());
    }
  }
  
    void displays() {
    for (int i = stopPoints .size()-1; i >= 0; i--) {
      StopPoint p = stopPoints .get(i);
      p.display();
    }
  }
  
}
