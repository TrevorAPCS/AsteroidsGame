int gFrames = 0;
String[] lines;
Spaceship player = new Spaceship(1);
ArrayList<Asteroid> asteroids;
ArrayList<Bullet> bullets = new ArrayList<Bullet>();
ArrayList<Targeter> targeters;
ArrayList<PowerUp> powerUps;
Star[] stars = new Star[100];
boolean left = false;
boolean right = false;
boolean up = false;
boolean down = false;
boolean shoot = false;
int sNumAsteroids = 30;
int sNumTargeters = 0;
int numAsteroids;
int numTargeters;
int bulletTimeLimit = (int)player.getReloadSpeed();
boolean menu = true;
boolean paused = false;
int menuState = 1;
Button start, controls, powerUpInfo, exit, bClassic, bSpeed, bTank, bShield, bDestroyer, resume, restart, exitGame;
int score = 0;
int highScore;
int scoreTimer;
Targeter targeter;
int shipType = 1;

void setup(){
  lines = loadStrings("HighScore.txt");
  try{
    highScore = int(lines[0]);
  }
  catch(NumberFormatException n){
    highScore = 0;
  }
  size(1000, 600);
  start = new Button(100, 400, 300, 100, "Start", 50);
  controls = new Button(100, 280, 300, 50, "Controls", 35);
  powerUpInfo = new Button(100, 340, 300, 50, "Power Ups", 35);
  exit = new Button(100, 425, 200, 75, "Exit", 50);
  bClassic = new Button(425, 425, 95, 75, "Classic", 20);
  bSpeed = new Button(525, 425, 95, 75, "Speed", 20);
  bTank = new Button(625, 425, 95, 75, "Tank", 20);
  bShield = new Button(725, 425, 95, 75, "Shield", 20);
  bDestroyer = new Button(825, 425, 95, 75, "Destroyer", 20);
  resume = new Button(350, 150, 300, 100, "Resume", 50);
  restart = new Button(350, 275, 300, 100, "Restart", 50);
  exitGame = new Button(350, 400, 300, 100, "Exit", 50);
}
void draw(){
  if(menu){
    background(0);
    fill(50);
    rect(50, 50, width - 100, height - 100);
    textAlign(CENTER);
    textSize(100);
    fill(#0C9CE8);
    player.setDirection(0);
    if(menuState == 1){
      text("Asteroids", 500, 150);
      startScreen();
    }
    else if(menuState == 2){
      text("Game Over", 500, 150);
      startScreen();
    }
    else if(menuState == 3){
      text("Controls:", 500, 150);
      textSize(30);
      textAlign(CORNER);
      text("Accelerate: UP", 250, 225);
      text("Reverse: DOWN", 250, 275);
      text("Turn Left: LEFT", 250, 325);
      text("Turn Right: RIGHT", 250, 375);
      text("HyperSpace: SPACE", 550, 225);
      text("Shoot Bullets: S", 550, 275);
      text("Pause Game: J", 550, 325);
      text("Activate Shield: A", 550, 375);
      textAlign(CENTER);
      exit.show();
    }
    else if(menuState == 4){
      text("Power Ups:", 500, 150);
      PowerUp hMenu = new PowerUp(100, 200, 1);
      PowerUp rMenu = new PowerUp(100, 250, 2);
      PowerUp shMenu = new PowerUp(100, 300, 3);
      PowerUp dbMenu = new PowerUp(100, 350, 4);
      hMenu.show();
      rMenu.show();
      shMenu.show();
      dbMenu.show();
      fill(#0C9CE8);
      textAlign(CORNER);
      textSize(20);
      text(hMenu.getName(), 150, 200);
      text(rMenu.getName(), 150, 250);
      text(shMenu.getName(), 150, 300);
      text(dbMenu.getName(), 150, 350);
      textSize(20);
      text(hMenu.getDescription(), 300, 200);
      text(rMenu.getDescription(), 300, 250);
      text(shMenu.getDescription(), 300, 300);
      text(dbMenu.getDescription(), 300, 350);
      exit.show();
    }
  }
  else{
    if(paused){
      fill(50);
      rect(300, 50, 400, 500);
      textSize(75);
      fill(#0C9CE8);
      text("Paused", width / 2, 125);
      resume.show();
      restart.show();
      exitGame.show();
    }
    else{
      gFrames++;
      background(0);
      for(int i = 0; i < stars.length; i++){
        (stars[i]).show();
      }
      moveBullets();
      player.move();
      collisions();
      controlShip();
      player.manageShield();
      player.manageBullets();
      player.manageHyperSpace();
      player.managePowerUps();
      player.show();
      trackScore();
      while(asteroids.size() < numAsteroids){
        addAsteroid();
      }
      while(targeters.size() < numTargeters){
        addTargeter();
      }
      for(int i = 0; i < asteroids.size(); i++){
        Asteroid a = asteroids.get(i);
        a.move();
        a.show();
      }
      for(int i = 0; i < targeters.size(); i++){
        Targeter t = (targeters.get(i));
        t.targetShip();
        t.moveShip();
        t.show();
      }
      for(int i = 0; i < powerUps.size(); i++){
        PowerUp p = (powerUps.get(i));
        p.move();
        p.show();
      }
      noStroke();
      playerStats();
      stroke(0);
    }
  }
}
void keyPressed(){
  if(menu == false){
    if(key == ' '){
      boolean collision = true;
      while(collision){
        player.hyperSpace();
        collision = false;
        for(int i = 0; i < asteroids.size(); i++){
          Asteroid a = asteroids.get(i);
          if(a.checkCollision((float)player.getX(), (float)player.getY())){
            collision = true;
          }
        }
      }
    }
  }
  if(keyCode == RIGHT){
    right = true;
  }
  if(keyCode == LEFT){
    left = true;
  }
  if(keyCode == UP){
    up = true;
  }
  if(keyCode == DOWN){
    down = true;
  }
  if(key == 's'){
    shoot = true;
  }
  if(key == 'j'){
    paused = !paused;
  }
  if(key == 'a'){
    player.activateShield();
  }
}
void keyReleased(){
  if(keyCode == RIGHT){
    right = false;
  }
  if(keyCode == LEFT){
    left = false;
  }
  if(keyCode == UP){
    up = false;
    player.setAccelerating(false);
  }
  if(keyCode == DOWN){
    down = false;
    player.setReversing(false);
  }
  if(key == 's'){
    shoot = false;
  }
}
void collisions(){
  double aa = atan2((float)player.getYspeed(), (float)player.getYspeed());
  double psi = (Math.sqrt(Math.pow(player.getXspeed(), 2) + Math.pow(player.getYspeed(), 2)));
  for(int i = 0; i < asteroids.size(); i++){
    Asteroid a = asteroids.get(i);
    double pa = atan2((float)a.getYspeed(), (float)a.getXspeed());
    if(a.checkCollision((float)player.getX(), (float)player.getY())){
      double asi = (Math.sqrt(Math.pow(a.getXspeed(), 2) + Math.pow(a.getYspeed(), 2)));
      double paDirection = (Math.atan2(player.getY() - a.getY(), player.getX() - a.getX()));
      double intrusion = (a.getSize()) - dist((float)player.getX(), (float)player.getY(), (float)a.getX(), (float)a.getY());
      player.unIntrude(intrusion, paDirection);
      a.calculateCollisionSpeed(psi, player.getMass(), aa);
      player.calculateCollisionSpeed(asi, a.getMass(), pa);
    }
    if(a.getHealth() <= 0){
      asteroids.remove(a);
      i -= 1;
    }
    for(int s = 0; s < asteroids.size(); s++){
      Asteroid b = asteroids.get(s);
      if(b != a){
        if(a.checkCollision((float)b.getX(), (float)b.getY())){
          aa = atan2((float)b.getYspeed(), (float)b.getYspeed());
          double ba = atan2((float)a.getYspeed(), (float)a.getYspeed());
          double asi = (Math.sqrt(Math.pow(a.getXspeed(), 2) + Math.pow(a.getYspeed(), 2)));
          double bsi = (Math.sqrt(Math.pow(b.getXspeed(), 2) + Math.pow(b.getYspeed(), 2)));
          double baDirection = (Math.atan2(b.getY() - a.getY(), b.getX() - a.getX()));
          double intrusion = (a.getSize()) - dist((float)a.getX(), (float)a.getY(), (float)b.getX(), (float)b.getY());
          b.unIntrude(intrusion, baDirection);
          a.calculateCollisionSpeed(bsi, b.getMass(), aa);
          b.calculateCollisionSpeed(asi, a.getMass(), ba);
          if(a.getHealth() <= 0){
            asteroids.remove(a);
            i -= 1;
          }
          if(b.getHealth() <= 0){
            asteroids.remove(b);
            s -= 1;
          }
        }
      }
    }
    for(int s = 0; s < powerUps.size(); s++){
      PowerUp b = powerUps.get(s);
      if(a.checkCollision((float)b.getX(), (float)b.getY())){
        aa = atan2((float)b.getYspeed(), (float)b.getYspeed());
        double ba = atan2((float)a.getYspeed(), (float)a.getYspeed());
        double asi = (Math.sqrt(Math.pow(a.getXspeed(), 2) + Math.pow(a.getYspeed(), 2)));
        double bsi = (Math.sqrt(Math.pow(b.getXspeed(), 2) + Math.pow(b.getYspeed(), 2)));
        double baDirection = (Math.atan2(b.getY() - a.getY(), b.getX() - a.getX()));
        double intrusion = (a.getSize()) - dist((float)a.getX(), (float)a.getY(), (float)b.getX(), (float)b.getY());
        b.unIntrude(intrusion, baDirection);
        a.calculateCollisionSpeed(bsi, b.getMass(), aa);
        b.calculateCollisionSpeed(asi, a.getMass(), ba);
        if(a.getHealth() <= 0){
          asteroids.remove(a);
          i -= 1;
        }
      }
    }
  }
  for(int i = 0; i < targeters.size(); i++){
    Targeter t = targeters.get(i);
    if(dist((float)t.getX(), (float)t.getY(), (float)player.getX(), (float)player.getY()) <= 15){
      double ta = atan2((float)t.getXspeed(), (float)t.getYspeed());
      double tsi = (Math.sqrt(Math.pow(t.getXspeed(), 2) + (Math.pow(t.getYspeed(), 2))));
      double ptDirection = (Math.atan2(t.getY() - player.getY(), t.getX() - player.getX()));
      double intrusion = (15 - dist((float)player.getX(), (float)player.getY(), (float)t.getX(), (float)t.getY()));
      t.unIntrude(intrusion, ptDirection);
      player.calculateCollisionSpeed(tsi, t.getMass(), ta);
      t.calculateCollisionSpeed(psi, player.getMass(), aa);
      if(t.getHealth() <= 0){
        targeters.remove(t);
        i -= 1;
      }
    }
  }
  for(int i = 0; i < powerUps.size(); i++){
  PowerUp p = powerUps.get(i);
    if(dist((float)p.getX(), (float)p.getY(), (float)player.getX(), (float)player.getY()) <= (p.getSize()/2) + 10){
      player.powerUpShip(p);
      powerUps.remove(p);
      i--;
    }
  }
  for(int i = 0; i < bullets.size(); i++){
  Bullet b = bullets.get(i);
    for(int s = 0; s < asteroids.size(); s++){
      Asteroid a = asteroids.get(s);
      if(dist((float)a.getX(), (float)a.getY(), (float)b.getX(), (float)b.getY()) <= a.getSize()){
        a.setMass(-0.5);
        bullets.remove(b);
        if(a.getHealth() <= 0){
          asteroids.remove(a);
          s -= 1;
        }
        score += 5;
      }
    }
    for(int s = 0; s < targeters.size(); s++){
      Targeter t = targeters.get(s);
      if(dist((float)t.getX(), (float)t.getY(), (float)b.getX(), (float)b.getY()) <= 5){
        t.setHealth(t.getHealth() - 50);
        t.setThrusters(false);
        t.setThrusterTimer(0);
        bullets.remove(b);
        if(t.getHealth() <= 0){
          targeters.remove(t);
          s -= 1;
        }
        score += 10;
      }
    }
  }
}
void controlShip(){
  if(right){
    player.turn(true);
  }
  if(left){
    player.turn(false);
  }
  if(up){
    player.accelerate(true);
  }
  if(down){
    player.accelerate(false);
  }
  if(shoot){
    if(player.getCanShoot()){
      if(player.getType() == 5){
        double rd = (player.getDirection() + 90) * (PI/180);
        if(player.getDoubleBullets()){
          bullets.add(new Bullet(player.getX() + (Math.cos(rd) * 5), player.getY() + (Math.sin(rd) * 5), player.getDirection(), #EAA211));
          bullets.add(new Bullet(player.getX() + (Math.cos(rd) * 5), player.getY() + (Math.sin(rd) * 5), player.getDirection(), #EAA211));
          bullets.add(new Bullet(player.getX() - (Math.cos(rd) * 5), player.getY() - (Math.sin(rd) * 5), player.getDirection(), #EAA211));
          bullets.add(new Bullet(player.getX() - (Math.cos(rd) * 5), player.getY() - (Math.sin(rd) * 5), player.getDirection(), #EAA211));
          player.shootBullet();
        }
        else{
          bullets.add(new Bullet(player.getX() + (Math.cos(rd) * 5), player.getY() + (Math.sin(rd) * 5), player.getDirection()));
          bullets.add(new Bullet(player.getX() - (Math.cos(rd) * 5), player.getY() - (Math.sin(rd) * 5), player.getDirection()));
          player.shootBullet();
        }
      }
      else{
        if(player.getDoubleBullets()){
          bullets.add(new Bullet(player.getX(), player.getY(), player.getDirection(), #EAA211));
          bullets.add(new Bullet(player.getX(), player.getY(), player.getDirection(), #EAA211));
          player.shootBullet();
        }
        else{
          bullets.add(new Bullet(player.getX(), player.getY(), player.getDirection()));
          player.shootBullet();
        }
      }
      if(player.getDoubleBullets()){
        if(player.getType() == 5){
          double rd = (player.getDirection() + 90) * (PI/180);
          bullets.add(new Bullet(player.getX() + (Math.cos(rd) * 5), player.getY() + (Math.sin(rd) * 5), player.getDirection(), #EAA211));
          bullets.add(new Bullet(player.getX() - (Math.cos(rd) * 5), player.getY() - (Math.sin(rd) * 5), player.getDirection(), #EAA211));
          player.shootBullet();
        }
        else{
          bullets.add(new Bullet(player.getX(), player.getY(), player.getDirection(), #EAA211));
          player.shootBullet();
        }  
      }
    }
  }
}
void moveBullets(){
  for(int i = 0; i < bullets.size(); i++){
    Bullet b = bullets.get(i);
    b.move();
    b.show();
    if(b.getOutOfBounds()){
      bullets.remove(b);
    }
  }
}
void playerStats(){
  fill(150, 150, 150, 100);
  rect(0, 0, 300, 25);
  rect(0, 30, 300, 25);
  rect(width - 300, 0, 300, 25);
  rect(width - 300, 30, 300, 25);
  fill(255, 0, 0, 75);
  rect(0, 0, (float)player.getHealthPercentage() * 300, 25);
  if(player.getHealth() <= 0){
    menu = true;
    menuState = 2;
    player.setDefaultColor();
    lines[0] = str(highScore);
    saveStrings("HighScore.txt", lines);
  }
  fill(#0C9CE8, 75);
  rect(width - 300, 0, (float)(player.getShieldPercentage() * 300), 25);
  fill(200, 75);
  rect(0, 30, (float)(player.getReloadPercentage() * 300), 25);
  fill(#0EC951, 75);
  rect(width - 300, 30, (float)(player.getHyperSpacePercentage() * 300), 25);
  fill(player.getPColor(), 75);
  rect(0, height - 25, (float)(player.getPowerUpPercentage() * width), 25);
  fill(255, 250);
  textAlign(CORNER);
  textSize(15);
  text("Health", 310, 20);
  text("Bullets", 310, 50);
  text("Shield", width - 350, 20);
  text("HyperSpace", width - 385, 50);
  textAlign(CENTER);
}
void mousePressed(){
  if(menu){
    if(menuState == 1 || menuState == 2){
      if(start.checkClick()){
        initializeObjects();
        menu = false;
      }
      if(controls.checkClick()){
        menuState = 3;
      }
      if(powerUpInfo.checkClick()){
        menuState = 4;
      }
      if(bClassic.checkClick()){
        shipType = 1;
        player = new Spaceship(shipType);
      }
      if(bSpeed.checkClick()){
        shipType = 2;
        player = new Spaceship(shipType);
      }
      if(bTank.checkClick()){
        shipType = 3;
        player = new Spaceship(shipType);
      }
      if(bShield.checkClick()){
        shipType = 4;
        player = new Spaceship(shipType);
      }
      if(bDestroyer.checkClick()){
        shipType = 5;
        player = new Spaceship(shipType);
      }
    }
    else if(menuState == 3 || menuState == 4){
      if(exit.checkClick()){
        menuState = 1;
      }
    }
  }
  else{
    if(paused){
      if(resume.checkClick()){
        paused = false;
      }
      if(restart.checkClick()){
        paused = false;
        player.setDefaultColor();
        lines[0] = str(highScore);
        saveStrings("HighScore.txt", lines);
        initializeObjects();
      }
      if(exitGame.checkClick()){
        player.setDefaultColor();
        lines[0] = str(highScore);
        saveStrings("HighScore.txt", lines);
        menu = true;
        menuState = 2;
      }
    }
  }
}
void initializeObjects(){
  player = new Spaceship(shipType);
  asteroids = new ArrayList<Asteroid>();
  targeters = new ArrayList<Targeter>();
  powerUps = new ArrayList<PowerUp>();
  numAsteroids = sNumAsteroids;
  numTargeters = sNumTargeters;
  gFrames = 0;
  for(int i = 0; i < numTargeters; i++){
    Targeter t = new Targeter(Math.random() * width, Math.random() * height, Math.random() * 360, 4, player);
    while(dist((float)t.getX(), (float)t.getY(), (float)player.getX(), (float)player.getY()) <= 50){
      t = new Targeter(Math.random() * width, Math.random() * height, Math.random() * 360, 4, player);
    }
    targeters.add(t);
  }
  for(int i = 0; i < stars.length; i++){
    stars[i] = new Star(Math.random() * 1000, (Math.random() * 800) + 50);
  }
  for(int i = 0; i < numAsteroids; i++){
    Asteroid a = new Asteroid(Math.random() * height, Math.random() * height, Math.random() * 360, 15, Math.random() * 2, Math.random() * 2);
    while(dist((float)a.getX(), (float)a.getY(), (float)player.getX(), (float)player.getY()) <= 50){
      a = new Asteroid(Math.random() * width, Math.random() * height, Math.random() * 360, 15, Math.random() * 2, Math.random() * 2);
    }
    asteroids.add(a);
  }
  score = 0;
  paused = false;
}
void trackScore(){
  scoreTimer++;
  if(scoreTimer > 5){
    scoreTimer = 0;
    score++;
  }
  if(score > highScore){
    highScore = score;
  }
  if(gFrames % 1500 == 0 && numAsteroids < 50){
    numAsteroids += 5;
  }
  if(gFrames % 1500 == 0 && numTargeters < 5){
    numTargeters += 1;
  }
  if(gFrames % 1500 == 0 && powerUps.size() <= 2){
    addPowerUp();
  }
  textAlign(CENTER);
  textSize(30);
  fill(#0C9CE8);
  text("Score: " + score, 500, 30);
  text(" HighScore: " + highScore, 500, 60);
}
void addAsteroid(){
  int spawnSide = (int)(Math.random() * 4);
  Asteroid a;
  if(spawnSide == 0){
    a = new Asteroid(-20, Math.random() * height, Math.random() * 360, 10, Math.random() * 2, Math.random() * 2);
  }
  else if(spawnSide == 1){
    a = new Asteroid(width + 20, Math.random() * height, Math.random() * 360, 10, Math.random() * 2, Math.random() * 2);
  }
  else if(spawnSide == 2){
    a = new Asteroid(Math.random() * width, -20, Math.random() * 360, 10, Math.random() * 2, Math.random() * 2);
  }
  else{
    a = new Asteroid(Math.random() * width, height + 20 * height, Math.random() * 360, 10, Math.random() * 2, Math.random() * 2);
  }
  asteroids.add(a);
}
void addTargeter(){
  int spawnSide = (int)(Math.random() * 4);
  Targeter t;
  if(spawnSide == 0){
    t = new Targeter(-20, Math.random() * height, Math.random() * 360, 4, player);
  }
  else if(spawnSide == 1){
    t = new Targeter(width + 20, Math.random() * height, Math.random() * 360, 4, player);
  }
  else if(spawnSide == 2){
    t = new Targeter(Math.random() * width, -20, Math.random() * 360, 4, player);
  }
  else{
    t = new Targeter(Math.random() * width, height + 20 * height, Math.random() * 360, 4, player);
  }
  targeters.add(t);
}
void addPowerUp(){
  int spawnSide = (int)(Math.random() * 4);
  PowerUp p;
  if(spawnSide == 0){
    p = new PowerUp(-20, Math.random() * height, (int)(Math.random() * 3 + 1));
  }
  else if(spawnSide == 1){
    p = new PowerUp(width + 20, Math.random() * height, (int)(Math.random() * 3 + 1));
  }
  else if(spawnSide == 2){
    p = new PowerUp(Math.random() * width, -20, (int)(Math.random() * 3 + 1));
  }
  else{
    p = new PowerUp(Math.random() * width, height + 20 * height, (int)(Math.random() * 3 + 1));
  }
  powerUps.add(p);
}
void startScreen(){
  start.show();
  controls.show();
  powerUpInfo.show();
  bClassic.show();
  bSpeed.show();
  bTank.show();
  bShield.show();
  bDestroyer.show();
  player.setX(475);
  player.setY(265);
  player.setShield(false);
  player.show();
  fill(#0C9CE8);
  textSize(30);
  text("Ship: " + player.getName(), 625, 275);
  text("Score: " + score, 175, 225);
  text("Highscore: " + highScore, 400, 225);
  textSize(20);
  textAlign(CORNER);
  for(int i = 0; i < player.getDescriptionLength(); i++){
    text(player.getDescription()[i], 425, 325 + (i * 25));
  }
  textSize(15);
  text("Acceleration: ", 750, 222);
  text("Turning: ", 750, 252);
  text("Health: ", 750, 282);
  text("Reload Speed: ", 750, 312);
  text("Shield Time: ", 750, 342);
  text("Hyper Space Recharge: ", 750, 372);
  textAlign(CENTER);
  noStroke();
  fill(75);
  rect(750, 225, 150, 15);
  rect(750, 255, 150, 15);
  rect(750, 285, 150, 15);
  rect(750, 345, 150, 15);
  fill(#0C9CE8);
  rect(750, 225, (float)((player.getAcceleration() / 0.25) * 150), 15);
  rect(750, 255, (float)((player.getTurning() / 2) * 150), 15);
  rect(750, 285, (float)((player.getSHealth() / 600) * 150), 15);
  rect(750, 315, 150, 15);
  rect(750, 345, (float)((player.getSShieldTimer() / 300) * 150), 15);
  rect(750, 375, 150, 15);
  fill(75);
  rect(900 - (float)((player.getReloadSpeed() / 15) * 150) + 40, 315, (float)((player.getReloadSpeed() / 15) * 150) - 40, 15);
  rect(900 - (float)((player.getSHyperSpaceTimer() / 250) * 150) + 40, 375, (float)((player.getSHyperSpaceTimer() / 250) * 150) - 40, 15);
  stroke(1);
}
