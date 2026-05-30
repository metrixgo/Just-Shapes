static class Obstacle{
  static float originalFadeInDur = 80;
  static float fadeInDur = 80;
  static float lethalDur = 15;
  static float fadeOutDur = 5;
  static float fadeInStr = 200;
  static float amplitude = 10;
  void update(){
    return;
  }
  boolean isDone(){
    return false;
  }
  boolean isLethal(){
    return false;
  }
  boolean isColliding(Player p){
    return false;
  }
}
