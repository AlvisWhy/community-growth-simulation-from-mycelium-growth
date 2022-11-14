Cluster c;
Boundary bd;
float radiusd = 20;
PrintWriter output;
ArrayList<PVector> ver = new ArrayList();
boolean startCannibilze = false;

void setup() {  
  smooth();
  size(600, 600);
  frameRate(10);
  background(0);
  noStroke();
  fill(255, 0, 0);
  c = new Cluster();
  ver.add(new PVector(50, 50));
  ver.add(new PVector(50, height-50));
  ver.add(new PVector(width, height));
  ver.add(new PVector(width-50, 50));
  bd = new Boundary(ver);
}


void draw() {
 /* if (mousePressed) {
    radiusd ++;
  } else {
    radiusd = 0;
  }
  */
  println(radiusd);
  pushStyle();
  fill(0, 0, 0, 10);
  rect(0, 0, width, height);
  popStyle();
  pushStyle();
  noFill();
  stroke(255);
  bd.display();
  popStyle();
  pushStyle();
  if (startCannibilze) {
    fill(255, 0, 0);
  } else {
    fill(255);
  }
  rect(0, 0, 40, 20);
  popStyle();


  c.searchLife() ;
  c.applyInForce();
  for (Msystem m : c.cluster) {
    m.b=bd;
    m.updatePoint() ;
    m.display();
    m.displays();
    drawline(m);
  }
  txtOutput1();
}

void txtOutput1() {
  output = createWriter("points.txt");

  for (Msystem m : c.cluster) {
    for (StopPoint p : m.stopPoints)
      output.println(p.location.x+","+p.location.y+','+p.gen);
  }

  output.flush(); 
  output.close();
}

void keyPressed()
{
  if (key=='p') noLoop();
  if (key=='s') loop();
  if (key=='q') {
    noLoop();
    background(0);
    for (Msystem M : c.cluster)
      drawline(M);
  }
}

void mousePressed() {
  if ( (mouseX <40) && (mouseX >0) && (mouseY >0) && (mouseY <20)) {
    if (startCannibilze)
    { 
      startCannibilze = false;
    } else {
      startCannibilze = true;
    }
  } 
  //method 2
  else {

    if (startCannibilze)

    { 
      for (Msystem m : c.cluster) {
        selfCannibilized(m, radiusd);
      }
    }

    //
    else
    {
      c.addSystem(new PVector (float(mouseX), float(mouseY)));
    }
  }
}





void drawline(Msystem m) {
  pushStyle();
  stroke(0, 255, 0, 20);
  for (StopPoint i : m.stopPoints) {
    for (StopPoint j : m.stopPoints) {
      if  (((j.gen.length() - i.gen.length())==1) && (j.gen.startsWith(i.gen))) {
        line(i.location.x, i.location.y, j.location.x, j.location.y);
      }
    }
  }
  popStyle();
}

void selfCannibilized(Msystem m, float d) {
  for (int i = m.stopPoints.size()-1; i >= 0; i--) {
    StopPoint t = m.stopPoints.get(i);
    if (dist(t.location.x, t.location.y, mouseX, mouseY) <= d)
      m.stopPoints.remove(t);
  }
}
