class Button{
  private int x, y, sX, sY, tSize;
  private String bText;
  public Button(int pX, int pY, int sizeX, int sizeY, String buttonText){
    x = pX;
    y = pY;
    sX = sizeX;
    sY = sizeY;
    bText = buttonText;
    tSize = 15;
  }
  public Button(int pX, int pY, int sizeX, int sizeY, String buttonText, int ts){
    x = pX;
    y = pY;
    sX = sizeX;
    sY = sizeY;
    bText = buttonText;
    tSize = ts;
  }
  public boolean checkClick(){
    if(mouseX >= x && mouseX <= x + sX && mouseY >= y && mouseY <= y + sY){
      return true;
    }
    else{
      return false;
    }
  }
  public void show(){
    textAlign(CENTER);
    textSize(tSize);
    if(mouseX >= x && mouseX <= x + sX && mouseY >= y && mouseY <= y + sY){
      fill(#0C9CE8);
      noStroke();
      rect(x, y, sX, sY);
      fill(0);
      text(bText, x + sX/2, y + sY/(1.5));
    }
    else{
      fill(100);
      noStroke();
      rect(x, y, sX, sY);
      fill(#0C9CE8);
      text(bText, x + sX/2, y + sY/(1.5));
    }
  }
}
