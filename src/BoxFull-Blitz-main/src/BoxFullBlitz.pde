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
  enemyTimer = new Timer(1*2000);
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
    deathScreen();
    background(20, 20, 20);
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
  Screen deathscreen = new Screen(1920, 1080);
  deathscreen.addButton(((width - 1200)), (height - 800), 500, 50, "Welcome to BoxFullBlitz", 200, 34);
  deathscreen.addButton(((width - 1200)), (height - 725), 500, 50, "Start Game", 200, 24);
  deathscreen.addButton(((width - 1200)), (height - 650), 500, 50, "Upgrades", 200, 24);
  deathscreen.addButton(((width - 1200)), (height - 575), 500, 50, "Settings", 200, 24);
  deathscreen.display();
  if (deathscreen.buttons.get(1).isPressed()) {
    activeScreen = screenManager.Start;
  }
}

void gameScreen() {

  Screen gameScreen = new Screen(1920, 1080);
  gameScreen.display();
  text(p1.health, 1920/2, 1080/2);
  p1.move();
  p1.drawPlayer();
  if (dodgeTimer.isFinished()) {
    if(p1.dodge()) {
      dodgeTimer.start();
  }
  }
  if (p1.health < 1) {
    activeScreen = screenManager.End;
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
      if(b.health <=0) {
        boxs.remove(i);
        continue;
    }
    p1.health -= b.damage;
    }
  }
  int dodgeCooldown = 3000;
  int timeLeft = max(0, dodgeCooldown - (millis() - dodgeTimer.savedTime));
  text("dodge cooldown: " + (timeLeft / 1000.0) + "s", 1920/2 + 100, 1080/2 +100);
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
