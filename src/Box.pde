class Box extends Enemy {
  int bHeight, bWidth;
  boolean hasWeapon = false;
  Player player;


  Box( float x, float y, int health, int speed, int bHeight, int bWidth, int damage, Player player) {
    super(x, y, health, speed, damage);
    this.bHeight = bHeight;
    this.bWidth = bWidth;
    this.player = player;
    damage = 15;
    health = 100;
  }
  void drawBox () {
    fill(100, 20, 10);
    rect(x, y, bWidth, bHeight);
    if (hasWeapon) {
      fill(200, 10, 10);
    }
    fill(225);
  }
  void move() {
    float dx = player.bx-x;
    float dy = player.by-y;
    float distance = dist(x, y, player.bx, player.by);
    if (distance > 15) {
      float ndx = dx / distance;
      float ndy = dy / distance;
      float moveX = ndx * speed;
      float moveY = ndy *speed;

      x += moveX;
      y += moveY;
    }
  }
}
