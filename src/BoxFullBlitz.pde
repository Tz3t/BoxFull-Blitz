import java.util.*;
enum screenManager {
  Start,
    Game,
    Upgrade,
    Setting,
    End
}
Player p1;
screenManager activeScreen = screenManager.Start;
ArrayList<Box> boxs = new ArrayList<Box>();
//ArrayList<powerups>
//ArrayList<projectiles>
Timer enemyTimer;
Timer dodgeTimer;
void setup() {
  size(1920, 1080);
  background(20, 80, 150);
  p1 = new Player(100, 100);
  enemyTimer = new Timer(1*200);
  enemyTimer.start();
  dodgeTimer = new Timer(1*3000);
  dodgeTimer.start();
}

void draw() {
  switch (activeScreen) {
  case Start:
    startScreen();
    break;
  case Game:
    background(20, 20, 20);
    gameScreen();
    break;
  case Upgrade:
    upgradeScreen();
    background(20, 20, 20);
    break;
  case Setting:
    settingScreen();
    background(20, 20, 20);
    break;
  case End:
    
    background(20, 20, 20);
    deathScreen();
    break;
  }
}
void startScreen() {
  Screen startscreen = new Screen(1920, 1080);
  startscreen.addButton(((width - 1200)), (height - 800), 500, 50, "Welcome to BoxFullBlitz", 200, 34);
  startscreen.addButton(((width - 1200)), (height - 725), 500, 50, "Start Game", 200, 24);
  startscreen.addButton(((width - 1200)), (height - 650), 500, 50, "Upgrades", 200, 24);
  startscreen.addButton(((width - 1200)), (height - 575), 500, 50, "Settings", 200, 24);
  startscreen.display();
  if (startscreen.buttons.get(1).isPressed()) {
    activeScreen = screenManager.Game;
  }
}
void deathScreen() {
  Screen deathScreen = new Screen(1920, 1080);
  deathScreen.display();
  deathScreen.addButton(((width - 1200)), (height - 800), 500, 50, "Welcome to BoxFullBlitz", 200, 34);
  deathScreen.addButton(((width - 1200)), (height - 725), 500, 50, "Main Menu", 200, 24);
  deathScreen.addButton(((width - 1200)), (height - 650), 500, 50, "ScoreBoard", 200, 24);
  deathScreen.addButton(((width - 1200)), (height - 575), 500, 50, "Quit to Desktop", 200, 24);
}

void gameScreen() {

  Screen gameScreen = new Screen(1920, 1080);
  gameScreen.display();
  text("Health:"+p1.health, 100, 10);
  p1.move();
  p1.drawPlayer();
  if (p1.health < 1) {
      activeScreen = screenManager.End;
   }
  if (dodgeTimer.isFinished()) {
    if (p1.dodge()) {
      dodgeTimer.start();
    }
  }

  if (enemyTimer.isFinished()) {
    boxs.add(new Box(int(random(width)), int(random(height)), 100, 1, 20, 20, 15, p1));
    enemyTimer.start();
  }
  for (int i=0; i <boxs.size(); i++) {
    Box b = boxs.get(i);
    b.drawBox();
    b.move();

    if (circleRectCollision(p1.bx, p1.by, 25, b.x, b.y, b.bWidth, b.bHeight)) {
      b.health -= 99;
      if (b.health <=0) {
        boxs.remove(i);
        continue;
      }
      p1.health -= b.damage;
    }
  }
  int dodgeCooldown = 3000;
  int timeLeft = max(0, dodgeCooldown - (millis() - dodgeTimer.savedTime));
  text("dodge cooldown: " + (timeLeft / 1000.0) + "s", 450, 10);
  int enemyCount = 0;
  for (Box b : boxs) {
    if (b != null) { // Just in case, to avoid any nulls
      enemyCount++;
    }
   
  }

  fill(255);
  textSize(20);
  text("Enemies: " + enemyCount, 250, 10); // Display below the time
  
}
void upgradeScreen() {
}

void settingScreen() {
}
void keyPressed() {
  if (key == 'w' || key == 'W') wPressed = true;
  if (key == 'a' || key == 'A') aPressed = true;
  if (key == 's' || key == 'S') sPressed = true;
  if (key == 'd' || key == 'D') dPressed = true;
  if (key == CODED && keyCode == SHIFT) shiftPressed = true;
}

void keyReleased() {
  if (key == 'w' || key == 'W') wPressed = false;
  if (key == 'a' || key == 'A') aPressed = false;
  if (key == 's' || key == 'S') sPressed = false;
  if (key == 'd' || key == 'D') dPressed = false;
  if (key == CODED && keyCode == SHIFT) shiftPressed = false;
}
boolean circleRectCollision(float cx, float cy, float radius, float rx, float ry, float rw, float rh) {
  float closestX = constrain(cx, rx, rx + rw);
  float closestY = constrain(cy, ry, ry + rh);

  float dx = cx - closestX;
  float dy = cy - closestY;

  return (dx * dx + dy * dy) < (radius * radius);
}
