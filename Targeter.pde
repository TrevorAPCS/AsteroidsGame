class Targeter extends Spaceship{
  private Spaceship target;
  private double mySpeed;
  private int maxRotation, hitTimer, startTimer;
  private boolean timer;
  public Targeter(int x, int y, int dir, int c, Spaceship t){
    super(x, y, dir, c);
    myCenterX = x;
    myCenterY = y;
    myPointDirection = dir;
    myColor = #FF2121;
    corners = c;
    myXspeed = 0;
    myYspeed = 0;
    xCorners = new int[]{10, -10, -5, -10};
    yCorners = new int[]{0, 5, 0, -5};
    accelerating = false;
    reversing = false;
    health = 300;
    target = t;
    mySpeed = 1;
    maxRotation = 1;
    hitTimer = 50;
    startTimer = hitTimer;
  }
  public void targetShip(){
    double targetDirection = Math.toDegrees(Math.atan2(target.getY() - myCenterY, target.getX() - myCenterX));
    if(targetDirection > PI * 2){targetDirection -= PI * 2;}
    if(targetDirection < 0){targetDirection += PI * 2;}
    if(Math.abs(targetDirection - myPointDirection) < maxRotation){
    }
    else if(myPointDirection > targetDirection){
      myPointDirection -= maxRotation;
    }
    else if(myPointDirection < targetDirection){
      myPointDirection += maxRotation;
    }
    if(myPointDirection > PI * 2){targetDirection -= PI * 2;}
    if(myPointDirection < 0){targetDirection += PI * 2;}
    //myPointDirection = Math.toDegrees(Math.atan2(target.getY() - myCenterY, target.getX() - myCenterX));
  }
  public void moveShip(){
    if(timer){
      setAccelerating(false);
      hitTimer++;
      myColor = #1203FF;
      if(hitTimer == startTimer){
        timer = false;
      }
    }
    else{
      myColor = #FF2121;
      setAccelerating(true);
      double dRadians =myPointDirection*(Math.PI/180);  
      myXspeed = mySpeed * Math.cos(dRadians);
      myYspeed = mySpeed * Math.sin(dRadians);
    }
    move();
  }
  public void activateTimer(){
    hitTimer = 0;
    timer = true;
  }
  public Spaceship getTarget(){
    return target;
  }
}
