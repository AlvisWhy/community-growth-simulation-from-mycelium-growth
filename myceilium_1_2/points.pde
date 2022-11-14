class Point {

  PVector location;
  PVector velocity;
  PVector acceleration;
  PVector formerLoction;
  boolean separation = false;
  float age;
  float Maxseparation = 2.0;
  float MaxseparationIn = 2.0;

  Point(PVector loc) {
    location = loc.copy();
    acceleration = new PVector(random(-0.2, 0.2), random(-0.2, 0.2));
    velocity = new PVector(random(-1, 1), random(-1, 1));
    age = 0;
  }

  Point(PVector loc, PVector vel) {
    location = loc.copy();
    acceleration = new PVector(random(-0.2, 0.2), random(-0.2, 0.2));
    velocity = vel;
    age = 0;
  }

  void run() {
    formerLoction = location.copy();
    update();
    display();
    age ++;
  }

  void update() {
    acceleration = new PVector(random(-0.2, 0.2), random(-0.2, 0.2));
    if(age > 5){
    //applyForce(separationPixel());
    }
    location.add(velocity);

    velocity.add(acceleration);
  }


  PVector expand() {
    PVector newPoint = location.copy();
    return newPoint;
  }


  void applyForce(PVector p) {
    acceleration.add(p);
  }

//according to Pixels

  /*PVector separationPixel() {
    float t = 5;
    PVector sumForce = new PVector();
    for (int i = int(location.x-t); i<= location.x+t; i++ ) {
      for (int j = int(location.y-t); j<= location.y+t; j++ ) {
        if (get(i, j)!=0) {
          PVector expel = new PVector(i-location.x, j- location.y);
          expel.normalize();
          sumForce.add(expel);
        }
      }
    }
    sumForce.normalize();
    sumForce.mult(MaxseparationIn);
    return sumForce;
  }
  */

  
  PVector separation(Msystem m) {
    float separationDistance = 5;
    ArrayList<Point> pts = m.points;
    ArrayList<StopPoint> spts = m.stopPoints;
    
    float sum = 0;
    PVector force = new PVector(0, 0);
    for ( Point p : pts) {
      float distance = dist( p.location.x, p.location.y, location.x, location.y);
      if ((distance > 0) && (distance<separationDistance)) {
        PVector separationForce  = PVector.add(location, p.location);
        separationForce.normalize();
        sum +=1;
        force.add(separationForce);
      }
    }
    
    for ( StopPoint p : spts) {
      float distance = dist( p.location.x, p.location.y, location.x, location.y);
      if ((distance > 0) && (distance<separationDistance)) {
        PVector separationForce  = PVector.add(location, p.location);
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



  void display() {
    ellipse(location.x, location.y, 1, 1);
    if (frameCount>=2) {
      //line(formerLoction.x,formerLoction.y,location.x,location.y);
    }
  }

  void Nextstep() {
    float t = random(0, 1);
    if ( t < 0.05) {
      separation = true ;
    } else {
      separation = false;
    }
  }

  boolean isDead() {
    if (age>20) {
      return true;
    } else {
      return false;
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
