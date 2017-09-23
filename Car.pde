class Car extends Rectangle{

  //Attributes:
  
  //PVector representing speed of car.
  private PVector speed;
  
  //whole number (Integer) representing the total acceleration/ deceleration of the car.
  private int maxA;
  
  //ArrayList of PVectors representing the path (Lights) in which the car will move.
  private ArrayList<PVector> path;
  
  //Integer representing the index of the next PVector to visit on the path.
  private int index;
  
  //boolean representing wether the car has reached it's final destination.
  private boolean isDone;
  
  //Integer representing the car's fitness.
  float fitness;
  
  //Next location
  ArrayList<PVector> targets;
  
  public Car(PVector loc /*, int maxA */, ArrayList<PVector> path){
    //constructor
    super(loc, 20, 10);
    this.speed = new PVector(0, 0);
    this.maxA = 3;
    this.path = path;
    this.targets = getTargets(super.loc.copy());
    this.index = 0;
    this.isDone = false;
    this.fitness = 0;
  }
  
  public void move(){
    
    if(this.isDone){
        return;
    }
    
    if(this.hitsLine() || super.isOutOfBounds() || this.index == this.path.size()){
        this.speed = new PVector(0, 0);
        super.show();
        this.isDone = true;
        return;
    }
    
    ellipse(this.targets.get(this.index).x, this.targets.get(this.index).y, 5, 5);
    if(new Rectangle(this.targets.get(this.index), 5, 5).isOutOfBounds()){
        println("OOB: "+this.targets.get(this.index));
    }

    if(super.loc.dist(targets.get(this.index)) < 5){
      this.index++;
      if(this.index != this.path.size())
          this.updateSpeed();
        
    }
    
    if(this.speed.equals(new PVector(0,0))){
      this.updateSpeed();
    }
    super.loc.add(this.speed);
    super.show();
  }
  
  private void updateSpeed(){
      //println("updateSpeed()");
      
      float angle = atan2(this.targets.get(this.index).y - super.loc.y, this.targets.get(this.index).x - super.loc.x);
      float newXSpeed = cos(angle) * maxA ;
      float newYSpeed = sin(angle) * maxA ;
      
      //println("XS: "+ newXSpeed+" YS: "+ newYSpeed);
      this.setSpeed(new PVector(newXSpeed, newYSpeed));
  }
  
  private boolean hitsLine(){
      for(int i = 0; i< lines.size(); i = i+2){
        if(lineDistance((int)lines.get(i).x, (int)lines.get(i).y, (int)lines.get(i+1).x, (int)lines.get(i+1).y, (int)super.loc.x, (int)super.loc.y) < 5){
            return true;
        }
      }
      return false;
  }
  
  ArrayList<PVector> getTargets(PVector current){
      ArrayList<PVector> ts = new ArrayList();
      for(PVector v: this.path){
          ts.add(current.add(v).copy());
      }
      //println(ts);
      return ts;
  }
  
  boolean getIsDone(){return this.isDone;}
  void setIsDone(boolean isDone){this.isDone = isDone;}
  
  void setFitness(float fitness){this.fitness = fitness;}
  float getFitness(){return this.fitness;}
  
  void setSpeed(PVector nSpeed){this.speed = nSpeed;}
  
  ArrayList<PVector> getPath(){return this.path;}
  
  
  ////////////////////////////////////////////////////////////
  float lineDistance(int x1, int y1, int x2, int y2, int mX, int mY) {
      PVector lineStart, lineEnd, mouse, projection, temp;
    
      lineStart = new PVector(x1, y1);
      lineEnd = new PVector(x2, y2);
      mouse = new PVector(mX, mY);
      
      temp = PVector.sub(lineEnd, lineStart);
    
      float lineLength = temp.x * temp.x + temp.y * temp.y; //lineStart.dist(lineEnd);
    
      if (lineLength == 0F) {
        return mouse.dist(lineStart);
      }
    
      float t = PVector.dot(PVector.sub(mouse, lineStart), temp) / lineLength;
    
      if (t < 0F) {
        return mouse.dist(lineStart);
      }
    
      if (t > 1F) {
        return mouse.dist(lineEnd);
      }
    
      projection = PVector.add(lineStart, PVector.mult(temp, t));
      return mouse.dist(projection);
}
  
  
}