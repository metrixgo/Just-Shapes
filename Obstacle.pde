abstract class Obstacle{
  float fadeInDur = 80;
  float lethalDur = 15;
  float fadeOutDur = 10;
  float fadeInStr = 100;
  float amplitude = 10;
  abstract void update();
  abstract boolean isDone();
  abstract boolean isLethal();
  abstract boolean isColliding(Player p);
}
