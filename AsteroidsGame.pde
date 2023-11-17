Spaceship player;
int sHealth;
ArrayList<Asteroid> asteroids;
ArrayList<Bullet> bullets = new ArrayList<Bullet>();
//ArrayList<Targeter> targeters = new ArrayList<Targeter>();
Floater[] floaters = new Floater[100];
boolean left = false;
boolean right = false;
boolean up = false;
boolean down = false;
boolean shoot = false;
int numAsteroids = 20;
int bulletTimer = 0;
int bulletTimeLimit = 10;
int thrusterTimer = 0;
int thrusterTimeLimit = 5;
boolean menu = true;
boolean gameOver = false;
int menuState = 1;
Button start;
Button controls;
Button exit;
int score = 0;
int highScore = 0;
int scoreTimer;
//Targeter targeter = new Targeter(400, 400, 0, 4, player);

void setup(){
  size(1000, 600);
  start = new Button(150, 400, 700, 100, "Start", 50);
  controls = new Button(150, 275, 700, 100, "Controls", 50);
  exit = new Button(100, 400, 200, 100, "Exit", 50);
  //targeters.add(targeter);
}
void draw(){
  background(0);
  if(menu){
    fill(50);
    rect(50, 50, width - 100, height - 100);
    textAlign(CENTER);
    textSize(100);
    fill(#0C9CE8);
    if(menuState == 1){
      text("Asteroids", 500, 150);
      start.show();
      controls.show();
      fill(#0C9CE8);
      textSize(40);
      text("Score: " + score, 350, 250);
      text("Highscore: " + highScore, 650, 250);
    }
    else if(menuState == 2){
      text("Game Over", 500, 150);
      start.show();
      controls.show();
      fill(#0C9CE8);
      textSize(40);
      text("Score: " + score, 350, 250);
      text("Highscore: " + highScore, 650, 250);
    }
    else if(menuState == 3){
      text("Controls:", 500, 150);
      textSize(30);
      text("Accelerate: UP", 500, 225);
      text("Reverse: DOWN", 500, 275);
      text("Turn Left: LEFT", 500, 325);
      text("Turn Right: RIGHT", 500, 375);
      text("HyperSpace: SPACE", 500, 425);
      text("Shoot Bullets: S", 500, 475);
      exit.show();
    }
  }
  else{
    for(int i = 0; i < floaters.length; i++){
      ((Star)floaters[i]).show();
    }
    /*for(int i = 0; i < targeters.size(); i++){
      Targeter t = (targeters.get(i));
      t.targetShip();
      t.moveShip();
      t.show();
    }*/
    moveBullets();
    thrustLimit();
    player.move();
    collisions();
    controlShip();
    player.show();
    healthBar();
    trackScore();
    while(asteroids.size() < numAsteroids){
      addAsteroid();
    }
  }
}
void keyPressed(){
  if(key == ' '){
    player.hyperSpace();
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
double calculateCollisionSpeed(double as, double bs, double am, double bm){
  return((am - bm)/(am + bm)) * as + ((2 * bm) / (am + bm)) * bs;
}
void collisions(){
  for(int i = 0; i < asteroids.size(); i++){
    Asteroid a = asteroids.get(i);
    a.move();
    a.show();
    double pa = atan2((float)a.getYspeed(), (float)a.getXspeed());
    double aa = atan2((float)player.getYspeed(), (float)player.getYspeed());
    if(a.checkCollision((float)player.getX(), (float)player.getY())){
      double psi = (Math.sqrt(Math.pow(player.getXspeed(), 2) + Math.pow(player.getYspeed(), 2)));
      double asi = (Math.sqrt(Math.pow(a.getXspeed(), 2) + Math.pow(a.getYspeed(), 2)));
      double paDirection = (Math.atan2(player.getY() - a.getY(), player.getX() - a.getX()));
      double intrusion = (a.getSize() / 2) - dist((float)player.getX(), (float)player.getY(), (float)a.getX(), (float)a.getY());
      player.unIntrude(intrusion, paDirection);
      a.calculateCollisionSpeed(psi, player.getMass(), aa);
      player.calculateCollisionSpeed(asi, a.getMass(), pa);
      if(a.getHealth() < 0){
        asteroids.remove(a);
      }
    }
    for(int s = 0; s < asteroids.size(); s++){
      Asteroid b = asteroids.get(s);
      if(b != a){
        if(a.checkCollision((float)b.getX(), (float)b.getY())){
          aa = atan2((float)b.getYspeed(), (float)b.getYspeed());
          double ba = atan2((float)a.getYspeed(), (float)a.getYspeed());
          double asi = (Math.sqrt(Math.pow(a.getXspeed(), 2) + Math.pow(a.getYspeed(), 2)));
          double bsi = (Math.sqrt(Math.pow(b.getXspeed(), 2) + Math.pow(b.getYspeed(), 2)));
          double baDirection = (Math.atan2(player.getY() - a.getY(), player.getX() - a.getX()));
          double intrusion = (a.getSize() / 2) - dist((float)a.getX(), (float)a.getY(), (float)b.getX(), (float)b.getY());
          a.unIntrude(intrusion, baDirection);
          a.calculateCollisionSpeed(bsi, b.getMass(), aa);
          b.calculateCollisionSpeed(asi, a.getMass(), ba);
          if(a.getHealth() < 0){
            asteroids.remove(a);
          }
          if(b.getHealth() < 0){
            asteroids.remove(b);
          }
        }
      }
    }
    /*for(int s = 0; s < targeters.size(); s++){
      Targeter b = targeters.get(s);
        if(a.checkCollision((float)b.getX(), (float)b.getY())){
          b.activateTimer();
          double bx = b.getXspeed();
          double by = b.getYspeed();
          double ax = a.getXspeed();
          double ay = a.getYspeed();
          a.setXspeed(bx);
          a.setYspeed(by);
          b.setXspeed(ax);
          b.setYspeed(ay);
      }
    }*/
  }
  for(int i = 0; i < bullets.size(); i++){
  Bullet a = bullets.get(i);
    for(int s = 0; s < asteroids.size(); s++){
      Asteroid b = asteroids.get(s);
      if(dist((float)a.getX(), (float)a.getY(), (float)b.getX(), (float)b.getY()) <= b.getSize() / 2){
        b.setHealth(-50);
        bullets.remove(a);
        if(b.getHealth() < 0){
          asteroids.remove(b);
        }
      }
    }
  }
}
void controlShip(){
  if(right){
    player.turn(2);
  }
  if(left){
    player.turn(-2);
  }
  if(up){
    player.setAccelerating(true);
    player.accelerate(0.25);
  }
  if(down){
    player.setReversing(true);
    player.accelerate(-0.10);
  }
  if(shoot){
    if(bulletTimer == 0){
      bullets.add(new Bullet(player.getX(), player.getY(), player.getDirection()));
      bulletTimer = bulletTimeLimit;
    }
    else{
      bulletTimer--;
    }
  }
}
void thrustLimit(){
  if(player.getThrusters() == false){
    thrusterTimer++;
    player.setColor(#FF0303);
    if(thrusterTimer == thrusterTimeLimit){
      player.setDefaultColor();
      player.setThrusters(true);
      thrusterTimer = 0;
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
void healthBar(){
  fill(150, 150, 150, 100);
  rect(0, 0, sHealth, 50);
  fill(255, 0, 0, 75);
  rect(0, 0, (float)player.getHealth(), 50);
  if(player.getHealth() <= 0){
    menu = true;
    menuState = 2;
  }
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
    }
    else if(menuState == 3){
      if(exit.checkClick()){
        menuState = 1;
      }
    }
  }
}
void initializeObjects(){
  player = new Spaceship(500, 450, 0, 4);
  sHealth  = (int)player.getHealth();
  asteroids = new ArrayList<Asteroid>();
  for(int i = 0; i < floaters.length; i++){
    floaters[i] = new Star(Math.random() * 1000, (Math.random() * 800) + 50);
  }
  for(int i = 0; i < numAsteroids; i++){
    Asteroid a = new Asteroid(Math.random() * 1000, (Math.random() * 800) + 50, Math.random() * 2 * PI, 10, Math.random() * 2, Math.random() * 2);
    while(dist((float)a.getX(), (float)a.getY(), (float)player.getX(), (float)player.getY()) <= 50){
      a = new Asteroid(Math.random() * width, (Math.random() * height) + 50, Math.random() * 2 * PI, 10, Math.random() * 2, Math.random() * 2);
    }
    asteroids.add(a);
  }
  score = 0;
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
  if(score == 300){
    numAsteroids += 1;
  }
  if(score == 600){
    numAsteroids += 1;
  }
  textAlign(CENTER);
  textSize(40);
  fill(#0C9CE8);
  text("Score: " + score, 500, 30);
  text(" HighScore: " + highScore, 500, 60);
}
void addAsteroid(){
  int spawnSide = (int)(Math.random() * 4);
  Asteroid a;
  if(spawnSide == 0){
    a = new Asteroid(-20, Math.random() * height, Math.random() * 2 * PI, 10, Math.random() * 2, Math.random() * 2);
  }
  else if(spawnSide == 1){
    a = new Asteroid(width + 20, Math.random() * height, Math.random() * 2 * PI, 10, Math.random() * 2, Math.random() * 2);
  }
  else if(spawnSide == 2){
    a = new Asteroid(Math.random() * width, -20, Math.random() * 2 * PI, 10, Math.random() * 2, Math.random() * 2);
  }
  else{
    a = new Asteroid(Math.random() * width, height + 20 * height, Math.random() * 2 * PI, 10, Math.random() * 2, Math.random() * 2);
  }
  asteroids.add(a);
}
