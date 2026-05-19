class Obstacle{
  float x;
  float y;
  float w;
  float h;
  float progress;
  
  PImage img;
  
  Obstacle(float x, float y, float w, float h){
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
    this.progress = 0;
    img = loadImage("images/obstacle.png");
  }
  
  void update(){
    tint(255, progress);
    image(img, x, y, w, h);
    noTint();
    progress += 3;
  }
  
  boolean done(){
    return progress > 300;
  }
}
