class Spaceship extends Floater{
  protected boolean accelerating, reversing, thrusters, shield, canShoot, canHyperSpace, hyperSpacing, doubleBullets;
  protected double health, mass, acceleration, turning, shieldTimer;
  protected int myDefaultColor, thrusterTimer, thrusterTimerRequirement, sHealth, flameOffset, sShieldTimer, reloadSpeed, sReloadSpeed, reloadTimer, sHyperSpaceTimer, hyperSpaceTimer, powerUpTimer, sPowerUpTimer;
  private int pTimer, pTime, pColor;
  protected String name;
  private String[] description;
  private double[] hyperSpaceAnimationPointsX, hyperSpaceAnimationPointsY;
  public Spaceship(){
    myCenterX = width / 2;
    myCenterY = height / 2;
    myPointDirection = 0;
    myColor = (#0C9CE8);
    myDefaultColor = myColor;
    myXspeed = 0;
    myYspeed = 0;
    accelerating = false;
    reversing = false;
    thrusters = true;
    thrusterTimer = 0;
    thrusterTimerRequirement = 5;
    name = "classic";
    corners = 3;
    xCorners = new int[]{10, -10, -10};
    yCorners = new int[]{0, 5, -5};
    health = 350;
    mass = 1.2;
    acceleration = 0.20;
    turning = 1.6;
    sHealth = (int)health;
    shield = false;
    canShoot = true;    
    reloadSpeed = 13;
    reloadTimer = reloadSpeed;
    sReloadSpeed = reloadSpeed;
    description = new String[]{"The classic"};
    hyperSpaceAnimationPointsX = new double[12];
    hyperSpaceAnimationPointsY = new double[12];
  }
  public Spaceship(int type){
    myCenterX = width / 2;
    myCenterY = height / 2;
    myPointDirection = 0;
    myColor = (#0C9CE8);
    myDefaultColor = myColor;
    myXspeed = 0;
    myYspeed = 0;
    accelerating = false;
    reversing = false;
    thrusters = true;
    thrusterTimer = 0;
    thrusterTimerRequirement = 5;
    shield = false;
    canShoot = true;    
    flameOffset = 0;
    hyperSpaceAnimationPointsX = new double[12];
    hyperSpaceAnimationPointsY = new double[12];
    if(type == 2){
      name = "Speed";
      corners = 4;
      xCorners = new int[]{10, -10, -5, -10};
      yCorners = new int[]{0, 5, 0, -5};
      health = 300;
      mass = 1;
      acceleration = 0.25;
      turning = 2;
      shieldTimer = 160;
      reloadSpeed = 10;
      hyperSpaceTimer = 140;
      description = new String[]{"A ship focused on acceleration and", "turning. don't go too fast!"};
    }
    else if(type == 3){
      name = "Tank";
      corners = 6;
      xCorners = new int[]{12, 0, -12, -6, -12, 0};
      yCorners = new int[]{0, 7, 7, 0, -7, -7};
      health = 600;
      mass = 2;
      acceleration = 0.12;
      turning = 1;
      shieldTimer = 120;
      reloadSpeed = 15;
      hyperSpaceTimer = 250;
      description = new String[]{"A ship built like a tank. Is very sluggish", "but has lots of health."};
    }
    else if(type == 4){
      name = "Shield";
      corners = 6;
      xCorners = new int[]{10, -8, -10, -6, -10, -8};
      yCorners = new int[]{0, 4, 6, 0, -6, -4};
      health = 250;
      mass = 1.2;
      acceleration = 0.15;
      turning = 1.4;
      shieldTimer = 300;
      reloadSpeed = 14;
      hyperSpaceTimer = 170;
      description = new String[]{"Has an extended shield run time. This", "means it takes longer to recharge", "though."};
    }
    else if(type == 5){
      name = "Destroyer";
      corners = 8;
      xCorners = new int[]{10, -10, 4, -10, -5, -10, 4, -10};
      yCorners = new int[]{0, 5, 5, 5, 0, -5, -5, -5};
      health = 160;
      mass = 1;
      acceleration = 0.17;
      turning = 1.7;
      shieldTimer = 85;
      reloadSpeed = 10;
      hyperSpaceTimer = 225;
      description = new String[]{"A ship focused on destruction that", "fires two bullets at a time."};
    }
    else{
      name = "Classic";
      corners = 3;
      xCorners = new int[]{10, -10, -10};
      yCorners = new int[]{0, 5, -5};
      health = 350;
      mass = 1.2;
      acceleration = 0.15;
      turning = 1.3;
      flameOffset = -3;
      shieldTimer = 200;
      reloadSpeed = 11;
      hyperSpaceTimer = 180;
      description = new String[]{"A well rounded ship that is decent", "in every area."};
    }
    sHealth = (int)health;
    sShieldTimer = (int)shieldTimer;
    sReloadSpeed = (int)reloadSpeed;
    reloadTimer = reloadSpeed;
    sHyperSpaceTimer = hyperSpaceTimer;
  }
  public String[] getDescription(){
    return description;
  }
  public int getDescriptionLength(){
    return description.length;
  }
  public double getSShieldTimer(){
    return sShieldTimer;
  }
  public void hyperSpace(){
    if(canHyperSpace){
      hyperSpaceTimer = 1;
      hyperSpacing = true;
      int angle = 0;
      for(int i = 0; i < hyperSpaceAnimationPointsX.length; i++){
        double randLength = Math.random() * 10 + 20;
        hyperSpaceAnimationPointsX[i] = randLength * Math.cos(angle);
        hyperSpaceAnimationPointsY[i] = randLength * Math.sin(angle);
        angle += 360 / hyperSpaceAnimationPointsX.length;
      }
    }
  }
  public boolean getHyperSpaceing(){
    return hyperSpacing;
  }
  public double getType(){
    return shipType;
  }
  public double getAcceleration(){
    return acceleration;
  }
  public double getTurning(){
    return turning;
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
  public String getName(){
    return name;
  }
  public double getDirection(){
    return myPointDirection;
  }
  public void setDirection(int d){
    myPointDirection = d;
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
  public void setAccelerating(boolean a){
    accelerating = a;
    if(thrusters == false){
      accelerating = false;
    }
  }
  public void setReversing(boolean r){
    reversing = r;
    if(thrusters == false){
      reversing = false;
    }
  }
  public double getHealth(){
    return health;
  }
  public double getSHealth(){
    return sHealth;
  }
  public double getHealthPercentage(){
    return health / sHealth;
  }
  public double getSHyperSpaceTimer(){
    return sHyperSpaceTimer;
  }
  public double getHyperSpacePercentage(){
    return (double)hyperSpaceTimer / (double)sHyperSpaceTimer;
  }
  public void setHealth(double h){
    health = h;
  }
  public void setThrusters(boolean b){
    thrusters = b;
  }
  public boolean getThrusters(){
    return thrusters;
  }
  public void accelerate(double amount){
    if(thrusters){
      super.accelerate(amount);
    }
  }
  public void setColor(int c){
    myColor = c;
  }
  public void setDefaultColor(){
    myColor = myDefaultColor;
  }
  public void activateShield(){
    if(shieldTimer == sShieldTimer){
      shield = true;
    }
  }
  public boolean getShield(){
    return shield;
  }
  public double getReloadSpeed(){
    return reloadSpeed;
  }
  public void show (){             
    //translate the (x,y) center of the ship to the correct position
    translate((float)myCenterX, (float)myCenterY);

    //convert degrees to radians for rotate()     
    float dRadians = (float)(myPointDirection*(Math.PI/180));
    
    //rotate so that the polygon will be drawn in the correct direction
    rotate(dRadians);
    if(hyperSpacing){
      for(int i = 0; i < hyperSpaceAnimationPointsX.length; i++){
        stroke(#0EC951);
        strokeWeight(2);
        line((float)hyperSpaceAnimationPointsX[i], (float)hyperSpaceAnimationPointsY[i], (float)(hyperSpaceAnimationPointsX[i] * ((float)hyperSpaceTimer/10)), (float)(hyperSpaceAnimationPointsY[i] * ((float)hyperSpaceTimer/10)));
        strokeWeight(1);
        stroke(0, 0, 0);
      }
    }
    else{
      //draw thruster flames
    if(accelerating){
      fill(#F07E0C);
      stroke(255, 0, 0);
      beginShape();
      vertex(-5 + flameOffset, 0);
      vertex(-8 + flameOffset, 3);
      vertex(-10 + flameOffset, 0);
      vertex(-8 + flameOffset, -3);
      vertex(-5 + flameOffset, 0);
      endShape(CLOSE);
      stroke(0);
    }
    if(reversing){
      if(shipType == 3){
        stroke(#F07E0C);
        line(7, 3, 9, 4);
        line(7, -3, 9, -4);
        stroke(0);
      }
      else{
        stroke(#F07E0C);
        line(5, 3, 7, 4);
        line(5, -3, 7, -4);
        stroke(0);
      }
    }
    
    fill(myColor);   
    stroke(myColor);    
    
    //draw the polygon
    beginShape();
    for (int nI = 0; nI < corners; nI++)
    {
      vertex(xCorners[nI], yCorners[nI]);
    }
    endShape(CLOSE);
    
    if(shield){
      fill(myColor, 75);
      stroke(myColor, 75);
      ellipse(0, 0, 25, 25);
    }
    }
    //"unrotate" and "untranslate" in reverse order
    rotate(-1*dRadians);
    translate(-1*(float)myCenterX, -1*(float)myCenterY);
    stroke(0);
  }
  public void accelerate(boolean forward){
    if(forward){
      accelerating = true;
      super.accelerate(acceleration);
    }
    else{
      reversing = true;
      super.accelerate(-(acceleration * 1/3));
    }
  }
  public void turn(boolean clockwise){
    if(clockwise){
      super.turn(turning);
    }
    else{
      super.turn(-turning);
    }
    if(myPointDirection > 360){
      myPointDirection -= 360;
    }
    if(myPointDirection < 0){
      myPointDirection += 360;
    }
  }
  public void manageShield(){
    if(shield){
      shieldTimer--;
      if(shieldTimer <= 0){
        shield = false;
      }
    }
    if(!shield && shieldTimer < sShieldTimer){
      shieldTimer += 0.5;
    }
  }
  public void manageBullets(){
    if(reloadTimer > reloadSpeed){
      reloadTimer = reloadSpeed;
    }
    if(reloadTimer == reloadSpeed){
      canShoot = true;
    }
    else{
      canShoot = false;
      reloadTimer++;
    }
  }
  public void manageHyperSpace(){
    if(hyperSpaceTimer > sHyperSpaceTimer){
      hyperSpaceTimer = sHyperSpaceTimer;
    }
    if(hyperSpaceTimer == sHyperSpaceTimer){
      canHyperSpace = true;
    }
    else{
      canHyperSpace = false;
      hyperSpaceTimer++;
    }
    if(hyperSpaceTimer == 10){
      myXspeed = 0;
      myYspeed = 0;
      myPointDirection = Math.random() * 360;
      myCenterX = Math.random() * 500;
      myCenterY = Math.random() * 500;
      hyperSpacing = false;
    }
  }
  public boolean getCanShoot(){
    return canShoot;
  }
  public void shootBullet(){
    reloadTimer = 0;
  }
  public double getReloadPercentage(){
    return (double)reloadTimer / (double)reloadSpeed;
  }
  public double getShieldPercentage(){
    return (double)shieldTimer / sShieldTimer;
  }
  public void setShield(boolean s){
    shield = s;
  }
  public void move(){
    super.move();
    if(thrusters == false){
      thrusterTimer++;
      if(thrusterTimer % 2 != 0){
        myColor = #FF0000;
      }
      else{
        myColor = myDefaultColor;
      }
      if(thrusterTimer == thrusterTimerRequirement){
        thrusters = true;
        thrusterTimer = 0;
        myColor = myDefaultColor;
      }
    }
  }
  public void setThrusterTimer(int t){
    thrusterTimer = t;
  }
  public void calculateCollisionSpeed(double others, double otherm, double dir){
    double msi = Math.sqrt(Math.pow(myXspeed, 2) + Math.pow(myYspeed, 2));
    double mso = ((mass - otherm)/(mass + otherm)) * msi + ((2 * otherm) / (mass + otherm)) * others;
    myXspeed = Math.cos(dir) * mso;
    myYspeed = Math.sin(dir) * mso;
    if(!shield){
      health -= (otherm * ((msi/2) + 2) * 2);
      thrusterTimer = 0;
      setThrusters(false);
    }
  }
  public void unIntrude(double amount, double dir){
    myCenterX += amount * Math.cos(dir) * 1.10;
    myCenterY += amount * Math.sin(dir) * 1.10;
  }
  public void powerUpShip(PowerUp p){
    health += p.getHealVal();
    if(health > sHealth){
      health = sHealth;
    }
    shieldTimer += p.getShieldVal();
    if(shieldTimer > sShieldTimer){
      shieldTimer = sShieldTimer;
    }
    if(p.getReloadVal() != 0){
      reloadSpeed = (int)((double)reloadSpeed * p.getReloadVal());
    }
    powerUpTimer = p.getTimeVal();
    sPowerUpTimer = powerUpTimer;
    pColor = p.getColor();
    if(p.getDoubleBullets()){
      doubleBullets = true;
    }
  }
  void managePowerUps(){
    if(powerUpTimer != 0){
      powerUpTimer--;
    }
    else{
      reloadSpeed = sReloadSpeed;
      doubleBullets = false;
    }
  }
  public double getPowerUpPercentage(){
    if(sPowerUpTimer == 0){
      return 0;
    }
    else{
      return (double)(powerUpTimer)/(double)(sPowerUpTimer);
    }
  }
  public int getPColor(){
    return pColor;
  }
  public boolean getDoubleBullets(){
    return doubleBullets;
  }
}
