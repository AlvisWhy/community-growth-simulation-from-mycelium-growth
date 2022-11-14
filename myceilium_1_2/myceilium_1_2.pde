Cluster c;

void setup() {
  fullScreen();
  frameRate(20);
  background(0);
  noStroke();
  fill(255, 0, 0, 20);
  noLoop();
  c = new Cluster();
}

void draw() {
   for (Msystem m : c.cluster) {
    m.updatePoint() ;
    m.display();
    m.displays();
  }
}

void mousePressed() {
  c.addSystem(new PVector (float(mouseX), float(mouseY)));
  loop();
}
