class Rectangle implements Obstacle{
  float x;
  float y;
  float w;
  float h;
  float t;
  float l;
  color c;
  
  Rectangle(float x, float y, float w, float h, float l, color c){
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
    this.t = 0;
    this.l = l;
    this.c = c;
  }
  
  void update(){
    fill(red(c), green(c), blue(c), t / l * 200);
    rect(x, y, w, h);
    t++;
  }
  
  boolean isColliding(Player p){
    return (x <= p.x + p.w) && (x + w >= p.x) && (y <= p.y + p.h) && (y + h >= p.y);
  }
}
