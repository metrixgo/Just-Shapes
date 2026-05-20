class Obstacle{
  float fadeInDur = 100;
  float lethalDur = 30;
  float fadeOutDur = 10;
  float fadeInStr = 80;
  void update(){}
  boolean isDone(){return false;}
  boolean isColliding(Player p){return false;}
}
