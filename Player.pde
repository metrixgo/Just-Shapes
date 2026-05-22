class Player{
  float x = width / 2;
  float y = height / 2 ;
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
    x = constrain(x, w / 2, width - w / 2);
    y = constrain(y, h / 2, height - h / 2);
    fill(c);
    rect(x, y, w, h);
  }
}
