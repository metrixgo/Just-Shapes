class Player{
  float x = 400;
  float y = 300;
  float w = 50;
  float dx = 0;
  float dy = 0;
  float speed = 2;
  
  PImage img;
  
  Player(){
    img = loadImage("images/player.png");
  }
  
  void update(){
    x += dx;
    y += dy;
    image(img, x, y, w, w);
  }
  
  boolean isColliding(Obstacle ob){
    return (x <= ob.x + ob.w) && (x + w >= ob.x) && (y <= ob.y + ob.h) && (y + w >= ob.y);
  }
}
