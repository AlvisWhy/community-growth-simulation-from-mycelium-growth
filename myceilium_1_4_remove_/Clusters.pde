class Cluster {
  ArrayList<Msystem> cluster;

  Cluster() {
    cluster = new ArrayList<Msystem>();
  }

  void addSystem(PVector t) {
    PVector s = t.copy();
    cluster.add(new Msystem(s));
  }


  void applyInForce() {
    for (Msystem m : cluster) {
      for (Point p : m.points) {
        PVector f = p.separation(m);
        p.applyForce(f);
      }
    }
  }

  void searchLife() {
    for (Msystem m : cluster) {
      for (Point p : m.points) {
        p.Dead = p.isDead(m);
      }
    }
  }
}
