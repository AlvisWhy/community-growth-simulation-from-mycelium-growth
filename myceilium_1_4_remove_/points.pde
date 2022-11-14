class Point {

  PVector location;
  PVector velocity;
  PVector acceleration;
  boolean separation = false;
  boolean Dead = false;
  float Maxseparation = 1.0;
  float MaxseparationIn = 1.0;
  int MaxDensityinArea = 10;
  float minBoundary = 20;
  String gen = new String("a");
  

  Point(PVector loc) {
    location = loc.copy();
    acceleration = new PVector(random(-0.2, 0.2), random(-0.2, 0.2));
    velocity = new PVector(random(-1, 1), random(-1, 1));
  }

  Point(PVector loc, PVector vel) {
    location = loc.copy();
    acceleration = new PVector(random(-0.2, 0.2), random(-0.2, 0.2));
    velocity = new PVector(random(-1, 1), random(-1, 1));
    velocity = vel;
  }

  void run() {
    update();
    display();
  }

  void update() {
    velocity.add(acceleration);
    location.add(velocity);
    velocity.normalize();
    acceleration = new PVector(random(-0.2, 0.2), random(-0.2, 0.2));
  }


  PVector expand() {
    PVector newPoint = location.copy();
    return newPoint;
  }


  void applyForce(PVector p) {
    acceleration.add(p);
  }


  PVector separation(Msystem m) {
    float separationDistance = 5;
    ArrayList<Point> pts = m.points;
    ArrayList<StopPoint> spts = m.stopPoints;

    float sum = 0;
    PVector force = new PVector(0, 0);
    for ( Point p : pts) {
      float distance = dist( p.location.x, p.location.y, location.x, location.y);
      if ((distance > 0) && (distance<separationDistance) && ((PVector.dot(velocity, PVector.sub(p.location, location)))<0)) {
        PVector separationForce  = PVector.sub(location, p.location);                                                                                                                     
        separationForce.normalize();
        sum +=1;
        force.add(separationForce);
      }
    }

    for ( StopPoint p : spts) {
      float distance = dist( p.location.x, p.location.y, location.x, location.y);
      if ((distance > 0) && (distance<separationDistance)) {
        PVector separationForce  = PVector.sub(location, p.location);
        separationForce.normalize();
        sum +=1;
        force.add(separationForce);
      }
      if (sum>0) {
        force.div(sum);
        force.mult(Maxseparation);
      }
    }

    return force;
  }


  Boolean isDead(Msystem m) {
    float searchDistance = 12;
    ArrayList<Point> pts = m.points;
    ArrayList<StopPoint> spts = m.stopPoints;

    float sum = 0;
    for ( Point p : pts) {
      float distance = dist( p.location.x, p.location.y, location.x, location.y);
      if ((distance > 0) && (distance<searchDistance)) {
        sum +=1;
      }
    }

    for ( StopPoint p : spts) {
      float distance = dist( p.location.x, p.location.y, location.x, location.y);
      if ((distance > 0) && (distance<searchDistance)) {
        sum +=1;
      }
    }

    if (sum>MaxDensityinArea) {
      return true;
    } else {
      return false;
    }
  }


  void display() {
    ellipse(location.x, location.y, 1, 1);
    if (frameCount>=2) {
      //line(formerLoction.x,formerLoction.y,location.x,location.y);
    }
  }

  void Nextstep() {
    float t = random(0, 1);
    if ( t < 0.1) {
      separation = true ;
    } else {
      separation = false;
    }
  }

  PVector DetectBoundary(Boundary b) {
    float mindist = 50;
    PVector p = new PVector();
    PVector F = new PVector();
    b.bps.add(b.bps.get(0));
    for (int i = 0; i<b.bps.size()-1; i++) {
      PVector p1 = b.bps.get(i);
      PVector p2 = b.bps.get(i+1);
      PVector ap = PVector.sub(location, p1);
      PVector ab = PVector.sub(p2, p1);
      ab.normalize();
      ab.mult(ap.dot(ab));
      PVector normalPoint = PVector.add(p1, ab);
      float n = dist(location.x, location.y, normalPoint.x, normalPoint.y);
      if (n<mindist) {
        mindist = n;
        p = normalPoint;
      }
    }
    if (mindist < minBoundary) {
      PVector m = PVector.sub(location, p);
      float t = m.mag();
      float l = map(minBoundary-t, 0, 50, 0, 2);
      m.normalize();
      m.mult(l);
      return m;
    } else {
      return F;
    }
  }




  /*
  
   void selfCannibalize(){
   
   }
   
   void seek(){
   
   
   }
   
   void steer(){
   
   }
   
   */
}
