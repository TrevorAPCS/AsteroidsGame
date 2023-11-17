class Asteroid extends Floater{
  private int mySize, health, collisionTimer, collisionTimeLimit;
  private double mass, rotSpeed;
  boolean collision;
  public Asteroid(double x, double y, double dir, int c, double xSpeed, double ySpeed){
    rotSpeed = Math.random();
    mySize = 40;
    myCenterX = x;
    myCenterY = y;
    myColor = 150;
    myPointDirection = dir;
    corners = c;
    myXspeed = xSpeed;
    myYspeed = ySpeed;
    xCorners = new int[]{0, 8, 16, 20, 12, 4, -12, -16, -12, -8};
    yCorners = new int[]{20, 16, 12, 0, -8, -16, 16, -4, -3, 16};
    mass = Math.random() * 2 + 2;
    health = (int)(Math.random() * 100) + 200;
    collisionTimer = 0;
    collisionTimeLimit = 5;
    collision = false;
  }
  boolean checkCollision(float cX, float cY){
   if(dist((float)myCenterX, (float)myCenterY, cX, cY) <= mySize / 2){
      return true;
    }
    else{
      return false;
    }
  }
  public double getX(){
    return myCenterX;
  }
  public double getY(){
    return myCenterY;
  }
  public void setX(double x){
    myCenterX = x;
  }
  public void setY(double y){
    myCenterY = y;
  }
  public double getXspeed(){
    return myXspeed;
  }
  public double getYspeed(){
    return myYspeed;
  }
  public double getMass(){
    return mass;
  }
  public void setXspeed(double s){
    myXspeed = s;
  }
  public void setYspeed(double s){
    myYspeed = s;
  }
  public double getHealth(){
    return health;
  }
  public void setHealth(int s){
    health += s;
    if(mass >= 1 && s < 0){
      mass -= Math.random() * 0.05 * s;
    }
  }
  public int getSize(){
    return mySize;
  }
  public void setCollision(){
    if(collision == false){
      health -= Math.random() * 30 + 20;
      if(mass >= 1){
        mass -= Math.random() * 0.5;
      }
    }
    collision = true;
  }
  public boolean getCollision(){
    return collision;
  }
  public void move(){
    if(collision){
      collisionTimer++;
      if(collisionTimer == collisionTimeLimit){
        collisionTimer = 0;
        collision = false;
      }
    }
    turn(rotSpeed);
    super.move();
  }
  public void calculateCollisionSpeed(double others, double otherm, double dir){
    double msi = Math.sqrt(Math.pow(myXspeed, 2) + Math.pow(myYspeed, 2));
    double mso = ((mass - otherm)/(mass + otherm)) * msi + ((2 * otherm) / (mass + otherm)) * others;
    myXspeed = Math.cos(dir) * mso;
    myYspeed = Math.sin(dir) * mso;
    setCollision();
  }
  public void unIntrude(double amount, double dir){
    myCenterX += amount * Math.cos(dir) * 1.10;
    myCenterY += amount * Math.sin(dir) * 1.10;
  }
}
