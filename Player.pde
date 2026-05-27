class Player{
  float x = width / 2;
  float y = height / 2 ;
  float w = 30;
  float h = 30;
  float speed = 10;
  int lives = 3;
  int invincibility = 8000;
  int t = -1;
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
    if((int)random(2) == 0 && (up || down || left || right)) particles.add(new Particle(x, y, c, 0));
    float temp = speed;
    if(dash && (up || down || left || right)){
      temp *= 10;
      particles.add(new Particle(x, y, c, 1));
    }
    dash = false;
    if(up) y -= temp;
    if(down) y += temp;
    if(left) x -= temp;
    if(right) x += temp;
    x = constrain(x, w / 2, width - w / 2);
    y = constrain(y, h / 2, height - h / 2);
    if(t >= 0 && t <= invincibility){
      fill(lerpColor(color(255), c, t * 1.0 / invincibility));
      t++;
    }
    else{
      fill(c);
      t = -1;
    }
    rect(x, y, w, h);
  }

  boolean hurt(){
    if(t >= 0 && t <= invincibility) return false;
    particles.add(new Particle(x, y, color(255), 2));
    w *= 0.8;
    h *= 0.8;
    lives--;
    t = 0;
    return lives <= 0;
  }
}
