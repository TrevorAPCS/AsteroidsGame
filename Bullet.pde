class Bullet extends Floater{
  private double mySpeed;
  private boolean outOfBounds;
  public Bullet(double x, double y, double dir){
    myCenterX = x;
    myCenterY = y;
    myPointDirection = dir;
    mySpeed = 5;
    outOfBounds = false;
    myColor = 200;
  }
  public Bullet(double x, double y, double dir, int c){
    myCenterX = x;
    myCenterY = y;
    myPointDirection = dir;
    mySpeed = 5;
    outOfBounds = false;
    myColor = c;
  }
  public double getX(){
    return myCenterX;
  }
  public double getY(){
    return myCenterY;
  }
  public boolean getOutOfBounds(){
    return outOfBounds;
  }
  public void move(){
    double dRadians =myPointDirection*(Math.PI/180);
    myXspeed = mySpeed * Math.cos(dRadians);
    myYspeed = mySpeed * Math.sin(dRadians);
    myCenterX += myXspeed;
    myCenterY += myYspeed;
    if(myCenterX > width || myCenterX < 0 || myCenterY > height || myCenterY < 0){
      outOfBounds = true;
    }
  }
  public void show(){
    fill(myColor);
    stroke(0);
    ellipse((float)myCenterX, (float)myCenterY, 5, 5);
  }
}
