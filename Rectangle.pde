class Rectangle{

  public PVector loc;
  private int w;
  private int h;
  
  public Rectangle(PVector loc, int w, int h){
    this.loc = loc;
    this.w = w;
    this.h = h;
  }
  
  public void show(){
    fill(0);
    ellipse(this.loc.x, this.loc.y, this.w / 2, this.w / 2);
  }
  
  public void setW(int w){this.w = w;}
  public void setH(int h){this.h = h;}
  public int getW(){return this.w;}
  public int getH(){return this.h;}
  
  public boolean collides(Rectangle other){
      if(other.loc.x > this.loc.x +this.w){
          //println("Enemy to the right");
          return false;
      }
      if(other.loc.x + other.getW() < this.loc.x){
          //println("Enemy to the left");
          return false;
      }
      if(other.loc.y > this.loc.y + this.h){
          //println("Enemy below");
          return false;
      }
      if(other.loc.y + other.getH()< this.loc.y){
          //println("Enemy below");
          return false;
      }
      return true;
  }
  
    private boolean isOutOfBounds(){
        //Acounting only for top left point.
        if(this.loc.x >= Constants.width || this.loc.x <= 0
            ||this.loc.y >= Constants.height || this.loc.y <= 0){
                //println("Out of bounds");  
                return true;
            }
        return false;
    }
}