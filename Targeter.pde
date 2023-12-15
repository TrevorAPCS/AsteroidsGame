class Targeter extends Spaceship{
  private Spaceship target;
  private double maxSpeed;
  private int maxRotation;
  public Targeter(double x, double y, double dir, int c, Spaceship t){
    myCenterX = x;
    myCenterY = y;
    myPointDirection = dir;
    myColor = 255;
    myDefaultColor = myColor;
    corners = c;
    myXspeed = 0;
    myYspeed = 0;
    xCorners = new int[]{10, -10, -5, -10};
    yCorners = new int[]{0, 5, 0, -5};
    accelerating = false;
    reversing = false;
    health = 300;
    target = t;
    maxRotation = 1;
    thrusterTimer = 0;
    thrusterTimerRequirement = 10;
    maxSpeed = 1;
  }
  public void targetShip(){
    double targetDirection = toDegrees(Math.atan2(target.getY() - myCenterY, target.getX() - myCenterX));
    boolean playerBehind = myCenterX - target.getX() > 0;
    if(targetDirection > 180){targetDirection -= 180;}
    if(targetDirection < -180){targetDirection += 180;}
    if(playerBehind){
      if(targetDirection >= 0){
        targetDirection = 180 - targetDirection;
      }
      else{
        targetDirection = -180 - targetDirection;
      }
      if(myPointDirection >= 0){
       myPointDirection = 180 - myPointDirection;
      }
      else{
        myPointDirection = -180 - myPointDirection;
      }
    }
    if(Math.abs(targetDirection - myPointDirection) <= maxRotation){
      myPointDirection = targetDirection;
    }
    else if(targetDirection - myPointDirection > maxRotation){
        myPointDirection += maxRotation;
    }
    else if(targetDirection - myPointDirection < -maxRotation){
        myPointDirection -= maxRotation;
    }
    if(playerBehind){
      if(myPointDirection >= 0){
       myPointDirection = 180 - myPointDirection;
      }
      else{
        myPointDirection = -180 - myPointDirection;
      }
    }
    if(myPointDirection > 180){myPointDirection -= 180;}
    if(myPointDirection < -180){myPointDirection += 180;}
  }
  public void moveShip(){
    if(thrusters){
      setAccelerating(true);
      accelerate(0.1);
      if(myXspeed > maxSpeed){
        myXspeed = maxSpeed;
      }
      if(myYspeed > maxSpeed){
        myYspeed = maxSpeed;
      }
      if(myXspeed < -maxSpeed){
        myXspeed = -maxSpeed;
      }
      if(myYspeed < -maxSpeed){
        myYspeed = -maxSpeed;
      }
    }
    move();
  }
  public Spaceship getTarget(){
    return target;
  }
  private double toDegrees(double radians){
    return radians * (180 / PI);
  }
}
