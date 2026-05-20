interface Obstacle{
  void update();
  boolean isDone();
  boolean isColliding(Player p);
}
