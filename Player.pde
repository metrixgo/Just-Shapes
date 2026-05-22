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
  boolean dash = false;
  color c;
  
  Player(color c){
    this.c = c;
  }
  
  void update(){
    if(gameState != 1) return;
    fill(c);
    rect(x, y, w, h);
    if(millis() % 100 < 50 && (up || down || left || right)) particles.add(new Particle(x, y, c));
    float temp = speed;
    if(dash && (up || down || left || right)){
      temp *= 10;
      particles.add(new Particle(x, y, c, true));
    }
    dash = false;
    if(up) y -= temp;
    if(down) y += temp;
    if(left) x -= temp;
    if(right) x += temp;
    x = constrain(x, w / 2, width - w / 2);
    y = constrain(y, h / 2, height - h / 2);
    fill(c);
    rect(x, y, w, h);
  }
}
