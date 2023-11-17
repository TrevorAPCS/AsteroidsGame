class Star extends Floater{
  public Star(double x, double y){
    myCenterX = x;
    myCenterY = y;
  }
  void show(){
    translate(0, 0);
    fill(255);
    ellipse((float)myCenterX, (float)myCenterY, 5, 5);
  }
}
