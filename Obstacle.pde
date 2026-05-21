abstract class Obstacle{
  float fadeInDur = 100;
  float lethalDur = 30;
  float fadeOutDur = 10;
  float fadeInStr = 100;
  abstract void update();
  abstract boolean isDone();
  abstract boolean isColliding(Player p);
}
