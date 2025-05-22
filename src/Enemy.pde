class Enemy {
  boolean intersectPlayer;
  float x, y;
  int health, speed, expLevel, damage;
  Enemy(float x, float y, int health, int speed, int damage) {
    this.x = x;
    this.y = y;
    this.health = health;
    this.speed = speed;
    this.damage = damage;
    expLevel = 0;
  }
}
void spawn() {
}
//boolean
void evolve() {
}
