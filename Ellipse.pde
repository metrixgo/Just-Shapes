class Ellipse extends Obstacle{
  float x;
  float y;
  float w;
  float h;
  float t;
  color c;
  
  Ellipse(float x, float y, float w, float h, color c){
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
    this.t = 0;
    this.c = c;
  }
  
  void update(){
    t++;
    if(t <= fadeInDur){
      fill(red(c), green(c), blue(c), t / fadeInDur * fadeInStr);
    }
    else if(t <= fadeInDur + lethalDur){
      fill(lerpColor(color(255), c, (t - fadeInDur) / lethalDur));
    }
    else if(t <= fadeInDur + lethalDur + fadeOutDur){
      fill(red(c), green(c), blue(c), lerp(alpha(c), 0, (t - fadeInDur - lethalDur) / fadeOutDur));
    }
    else{
      fill(0, 0, 0, 0);
    }
    ellipse(x, y, w, h);
  }
  
  boolean isLethal(){
    return t <= fadeInDur + lethalDur;
  }
  
  boolean isDone(){
    return t >= fadeInDur + lethalDur + fadeOutDur;
  }
  
  boolean isColliding(Player p){
    float dx = (constrain(x, p.x, p.x + p.w) - x) / w * 2;
    float dy = (constrain(y, p.y, p.y + p.h) - y) / h * 2;
    return (dx * dx + dy * dy) <= 1;
  }
}
