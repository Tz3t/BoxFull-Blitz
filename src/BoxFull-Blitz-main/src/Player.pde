
// add diagnol dodges

enum WeaponType {
  rangedWeapon,
    meleeWeapon
}

boolean wPressed = false;
boolean aPressed = false;
boolean sPressed = false;
boolean dPressed = false;
boolean shiftPressed = false;
class Player {
  int health, damage, vx, vy, money, maxSpeed;
  float bx, by;
  boolean isAlive, hasRangedWeapon, hasMeleeWeapon;




  WeaponType inHandWeapon = WeaponType.meleeWeapon;
  Player(int bx, int by) {
    this.bx = bx;
    this.by = by;
    health = 100;
    vx = 0;
    vy = 0;
    money = 0;
    damage = 1;
    maxSpeed = 5;
  }



  void Attack() {
  }
  boolean dodge() {
    if (shiftPressed && wPressed) {
      by -= 200;
      return true;
    } else if (shiftPressed && sPressed) {
      by += 200;
      return true;
    } else if (shiftPressed && aPressed) {
      bx -= 200;
      return true;
    } else if (shiftPressed && dPressed) {
      bx += 200;
      return true;
    } else
      return false;
  }
  void move() {
    vx = 0;
    vy = 0;

    if (wPressed) vy = -1;
    if (sPressed) vy = 1;
    if (aPressed) vx = -1;
    if (dPressed) vx = 1;

    bx += vx * maxSpeed;
    by += vy * maxSpeed;
  }



  void drawPlayer() {
    fill(255);
    circle(bx, by, 50);
  }
}
