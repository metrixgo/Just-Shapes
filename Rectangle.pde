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
    t++;
    if(t <= l){
      fill(red(c), green(c), blue(c), t / l * 100);
    }
    else if(t <= l + 30){
      fill(lerpColor(color(255), c, (t - l) / 30));
    }
    else if(t <= l + 40){
      fill(red(c), green(c), blue(c), lerp(alpha(c), 0, (t - l - 30) / 10));
    }
    else{
      fill(0, 0, 0, 0);
    }
    rect(x, y, w, h);
  }
  
  boolean isLethal(){
    return t <= l + 30;
  }
  
  boolean isDone(){
    return t >= l + 40;
  }
  
  boolean isColliding(Player p){
    return (x <= p.x + p.w) && (x + w >= p.x) && (y <= p.y + p.h) && (y + h >= p.y);
  }
}
