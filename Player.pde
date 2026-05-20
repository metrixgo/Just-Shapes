class Player{
  float x = 400;
  float y = 300;
  float w = 50;
  float h = 50;
  float dx = 0;
  float dy = 0;
  float speed = 10;
  color c;
  
  Player(color c){
    this.c = c;
  }
  
  void update(){
    x += dx;
    y += dy;
    fill(c);
    rect(x, y, w, h);
  }
}
