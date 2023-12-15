class PowerUp extends Asteroid{
  private int type, size, healVal, timeVal, shieldVal;
  private double reloadVal;
  private boolean doubleBullets;
  private String name;
  private String description;
  public PowerUp(double x, double y, int t){
    myCenterX = x;
    myCenterY = y;
    myXspeed = Math.random() * 2;
    myYspeed = Math.random() * 2;
    size = 20;
    type = t;
    doubleBullets = false;
    if(t == 2){
      //faster reload speed
      myColor = 200;
      healVal = 0;
      timeVal = (int)(Math.random() * 300) + 100;
      reloadVal = Math.random() * 0.25 + 0.5;
      shieldVal = 0;
      name = "Quick Reload";
      description = "Reduces reload speed by 25 - 50% for a couple seconds";
    }
    else if(t == 3){
      //shield recharge
      myColor = #0C9CE8;
      reloadVal = 1;
      healVal = 0;
      timeVal = 0;
      shieldVal = (int)(Math.random() * 25 + 25);
      name = "Shield Boost";
      description = "Recharges shield by up to 50 points. No effect if shield recharge is at max.";
    }
    else if(t == 4){
      //double bullets
      myColor = #EAA211;
      healVal = 0;
      timeVal = (int)(Math.random() * 300) + 100;
      reloadVal = 1;
      shieldVal = 0;
      doubleBullets = true;
      name = "2X damage";
      description = "Ship will now shoot 2X damage orange bullets for a coupe seconds";
    }
    else{
      //healing
      type = 1;
      myColor = #FF0000;
      healVal = (int)(Math.random() * 25 + 25);
      timeVal = 0;
      reloadVal = 1;
      shieldVal = 0;
      name = "Healing";
      description = "Heals damage by up to 50 HP. No effect if ship has maximum HP.";
    }
  }
  public String getDescription(){
    return description;
  }
  public String getName(){
    return name;
  }
  public boolean getDoubleBullets(){
    return doubleBullets;
  }
  public int getShieldVal(){
    return shieldVal;
  }
  public int getColor(){
    return myColor;
  }
  public int getType(){
    return type;
  }
  public double getX(){
    return myCenterX;
  }
  public double getY(){
    return myCenterY;
  }
  public int getHealVal(){
    return healVal;
  }
  public int getTimeVal(){
    return timeVal;
  }
  public double getReloadVal(){
    return reloadVal;
  }
  public void show(){
    fill(myColor, 75);   
    stroke(myColor, 75);    
    
    //translate the (x,y) center of the ship to the correct position
    translate((float)myCenterX, (float)myCenterY);
    ellipse(0, 0, size, size);
    translate(-1*(float)myCenterX, -1*(float)myCenterY); 
  }
  public void calculateCollisionSpeed(double others, double otherm, double dir){
    double msi = Math.sqrt(Math.pow(myXspeed, 2) + Math.pow(myYspeed, 2));
    double mso = ((mass - otherm)/(mass + otherm)) * msi + ((2 * otherm) / (mass + otherm)) * others;
    myXspeed = Math.cos(dir) * mso;
    myYspeed = Math.sin(dir) * mso;
  }
}
