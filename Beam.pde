class Beam extends Obstacle{
  float loc;
  int dir;
  float w;
  float t;
  color c;
  
  Beam(float loc, int dir, float w, color c){
    this.loc = loc;
    this.dir = dir;
    this.t = 0;
    this.w = w;
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
    
    if(dir == 1){
      rect(0, loc, width + height, w);
    }
    else{
      rect(loc, 0, w, width + height);
    }
  }
  
  boolean isLethal(){
    return t < fadeInDur + lethalDur && t > fadeInDur;
  }
  
  boolean isDone(){
    return t >= fadeInDur + lethalDur + fadeOutDur;
  }
  
  boolean isColliding(Player p){
    if(p == null) return false;
    if(dir == 1){
      return (loc <= p.y + p.h) && (loc + w >= p.y);
    }
    else{
      return (loc <= p.x + p.w) && (loc + w >= p.x);
    }
  }
}
