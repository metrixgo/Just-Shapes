class Player{
  float x = 400;
  float y = 300;
  float w = 30;
  float h = 30;
  float speed = 10;
  boolean up = false;
  boolean down = false;
  boolean left = false;
  boolean right = false;
  color c;
  
  Player(color c){
    this.c = c;
  }
  
  void update(){
    if(gameState != 1) return;
    fill(c);
    rect(x, y, w, h);
    if(up) y -= speed;
    if(down) y += speed;
    if(left) x -= speed;
    if(right) x += speed;
    x = constrain(x, 0, width - w);
    y = constrain(y, 0, height - h);
    fill(c);
    rect(x, y, w, h);
  }
}
