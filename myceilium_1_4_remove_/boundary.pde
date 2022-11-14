class Boundary {
  ArrayList<PVector> bps ;
  Boundary(ArrayList<PVector> ps) {
    bps = new ArrayList<PVector>();
    bps = ps;
  }

  void display() {
    beginShape();
    for (PVector p : bps) {
      vertex(p.x, p.y);
    }
    vertex(bps.get(0).x, bps.get(0).y);
    endShape();
  }
}
