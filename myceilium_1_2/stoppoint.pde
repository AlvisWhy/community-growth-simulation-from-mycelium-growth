class StopPoint{
  PVector location;
  
  StopPoint(PVector p){
    location = p;
    
  }
  
  void display(){
     ellipse(location.x, location.y, 1, 1);
    
  }

}
